import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:matrix_sdk_ffi/matrix_sdk_ffi.dart' as mffi;
import 'package:path_provider/path_provider.dart';

String documentPath = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize UniFFI bindings and dynamic library loading
  mffi.ensureInitialized();
  final dataPath = await getApplicationDocumentsDirectory();
  documentPath = dataPath.path;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

Map<String, dynamic> toJson(mffi.Session session) {
  return {
    'accessToken': session.accessToken,
    if (session.refreshToken != null) 'refreshToken': session.refreshToken,
    'userId': session.userId,
    'deviceId': session.deviceId,
    'homeserverUrl': session.homeserverUrl,
    if (session.oidcData != null) 'oidcData': session.oidcData,
    'slidingSyncVersion': session.slidingSyncVersion.name,
  };
}

mffi.Session fromJson(Map<String, dynamic> json) {
  return mffi.Session(
    accessToken: json['accessToken'],
    refreshToken: json['refreshToken'],
    userId: json['userId'],
    deviceId: json['deviceId'],
    homeserverUrl: json['homeserverUrl'],
    oidcData: json['oidcData'],
    slidingSyncVersion: mffi.SlidingSyncVersion.values.firstWhere(
      (e) => e.name == json['slidingSyncVersion'],
    ),
  );
}

class SessionDelegate extends mffi.ClientSessionDelegate {
  @override
  mffi.Session retrieveSessionFromKeychain(String userId) {
    final sessionFile = File('$documentPath/session.json');
    final sessionJsonString = sessionFile.readAsStringSync();
    final sessionJson = jsonDecode(sessionJsonString);
    return fromJson(sessionJson);
  }

  @override
  void saveSessionInKeychain(mffi.Session session) {
    final sessionJson = toJson(session);
    final sessionJsonString = jsonEncode(sessionJson);
    final sessionFile = File('$documentPath/session.json');
    sessionFile.writeAsString(sessionJsonString);
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initClient();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Future<void> initClient() async {
    try {
      // Initialize Rust tracing/logging and the Tokio runtime.
      // Writes logs to stdout and also to rotating files under the app support dir.

      final tracingConfig = mffi.TracingConfiguration(
        logLevel: mffi.LogLevel.debug, // use trace for maximum verbosity
        traceLogPacks: [],
        extraTargets: const <String>[],
        writeToStdoutOrSystem: true, // write to stdout/system log
        writeToFiles: mffi.TracingFileConfiguration(
          path: '$documentPath/logs',
          filePrefix: 'matrix-sdk',
        ),
      );
      try {
        mffi.initPlatform(tracingConfig, false);
      } catch (e) {
        print('Error: $e');
      }
      final clientBuilder = mffi.ClientBuilder()
          .homeserverUrl('http://localhost:8008')
          .sessionPaths('$documentPath/data', '$documentPath/cache')
          .sessionPassphrase('kushalmahapatro')
          // Avoid using Dart callback interfaces from Rust threads to prevent
          // "Cannot invoke native callback outside an isolate" crashes.
          .autoEnableCrossSigning(true)
          .slidingSyncVersionBuilder(mffi.SlidingSyncVersionBuilder.native)
          .requestConfig(
            mffi.RequestConfig(
              retryLimit: 3,
              timeout: 5,
              maxConcurrentRequests: 10,
              maxRetryTime: 5,
            ),
          );
      final client = await clientBuilder.build();

      final sessionFile = File('$documentPath/session.json');
      if (sessionFile.existsSync()) {
        final sessionJsonString = sessionFile.readAsStringSync();
        final sessionJson = jsonDecode(sessionJsonString);
        final session = fromJson(sessionJson);
        await client.restoreSession(session);
      } else {
        try {
          await client.homeserverLoginDetails();
        } catch (e) {
          print('Error: $e');
        }

        try {
          await client
              .login('kushal', 'kushalmahapatro', 'km', null)
              .timeout(const Duration(seconds: 30));
          // Login succeeded
          final session = client.session();
          final sessionJson = toJson(session);
          final sessionJsonString = jsonEncode(sessionJson);
          final sessionFile = File('$documentPath/session.json');
          sessionFile.writeAsString(sessionJsonString);
        } on mffi.MatrixApiClientException catch (e) {
          // ignore: avoid_print
          print('Login Matrix API error: ${e.code} ${e.msg} ${e.details}');
          return;
        } on mffi.GenericClientException catch (e) {
          // ignore: avoid_print
          print('Login client error: ${e.msg} ${e.details}');
          return;
        } on TimeoutException {
          // ignore: avoid_print
          print('Login timed out');
          return;
        }
      }

      final availableSlidingSyncVersions =
          await client.availableSlidingSyncVersions();
      print('Available sliding sync versions: $availableSlidingSyncVersions');

      final syncServiceBuilder = client.syncService();
      syncServiceBuilder.withOfflineMode();
      syncServiceBuilder.withSharePos(true);
      syncServiceBuilder.withCrossProcessLock();
      final syncService = await syncServiceBuilder.finish();
      // syncService.state(SyncServiceStateObserver());
      final roomListService = syncService.roomListService();
      final rooms = await roomListService.allRooms();
      // ignore: avoid_print
      print('Rooms: $rooms');

      rooms.loadingState(RoomListLoadingStateObserver());
      rooms.entriesWithDynamicAdapters(10, RoomListEntriesListener());
      // roomListService.state(RoomListServiceStateListener());

      for (final room in client.rooms()) {
        print('Room: ${room.displayName()}');
      }

      client.createRoom(
        mffi.CreateRoomParameters(
          name: 'test Room',
          isEncrypted: true,
          isDirect: false,
          visibility: mffi.PublicRoomVisibility(),
          preset: mffi.RoomPreset.publicChat,
        ),
      );
    } catch (e, st) {
      // ignore: avoid_print
      print('Init error: $e\n$st');
    }
  }
}

class RoomListServiceStateListener extends mffi.RoomListServiceStateListener {
  @override
  void onUpdate(mffi.RoomListServiceState state) {
    print('Room list service state: $state');
  }
}

class RoomListEntriesListener extends mffi.RoomListEntriesListener {
  @override
  void onUpdate(List<mffi.RoomListEntriesUpdate> roomEntriesUpdate) {
    for (final update in roomEntriesUpdate) {
      print('Room list entries update: $update');
    }
  }
}

class RoomListLoadingStateObserver extends mffi.RoomListLoadingStateListener {
  @override
  void onUpdate(mffi.RoomListLoadingState state) {
    print('Room list loading state: $state');
  }
}

class SyncServiceStateObserver extends mffi.SyncServiceStateObserver {
  @override
  void onUpdate(mffi.SyncServiceState state) {
    print('State: $state');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
// 