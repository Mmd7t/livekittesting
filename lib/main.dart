import 'package:flutter/material.dart';
import 'package:livekit_example/navigationtime.dart';
import 'package:livekit_example/theme.dart';
import 'package:logging/logging.dart';
import 'package:intl/intl.dart';
import 'pages/connect.dart';

void main() async {
  final format = DateFormat('HH:mm:ss');
  // configure logs for debugging
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((record) {
    print('${format.format(record.time)}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();

  runApp( LiveKitExampleApp());
}

class LiveKitExampleApp extends StatelessWidget {
  //
   LiveKitExampleApp({
    Key? key,
  }) : super(key: key);
final TimingNavigatorObserver timingObserver = TimingNavigatorObserver();
  @override
  Widget build(BuildContext context) => MaterialApp(
    navigatorObservers: [timingObserver],
        title: 'LiveKit',
        theme: LiveKitTheme().buildThemeData(context),
        home:  ConnectPage(timingObserver: timingObserver),
      );
}
