import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_example/agents/api_calls.dart';
import 'package:livekit_example/navigationtime.dart';

import '../exts.dart';
import 'room.dart';

class ConnectPage extends StatefulWidget {
  //
   ConnectPage({
    Key? key,required this.timingObserver
  }) : super(key: key);
 final TimingNavigatorObserver timingObserver;
  @override
  State<StatefulWidget> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  bool _busy = false;
  String livekitToken = '';
  Future<void> _connect(
      BuildContext ctx, bool isItCreatingtheCall, bool isItVoiceCall) async {
    try {
      setState(() {
        _busy = true;
      });

      if (isItCreatingtheCall) {
        await ApiCalls.createRoom(
          authToken:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyaHJmTDdtYnh0Zk9vdEUzRHF4dUpOSXNDdTUiLCJpYXQiOjE3MTk4MjMwOTMsImV4cCI6MTcxOTkwOTQ5M30.-1zneVMzdW3hZsaai7arkbtKz6dt0mCs6TArwkktKpA',
          roomName: 'Tezda Live',
          participantIdentity: 'Medhat Mostafa',
        ).then((val) {
          setState(() {
            livekitToken = val!.data!.token!;
          });
        });
      } else {
        await ApiCalls.generateLKAccessToken(
          authToken:
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyaHJmTDdtYnh0Zk9vdEUzRHF4dUpOSXNDdTUiLCJpYXQiOjE3MTk4MjMwOTMsImV4cCI6MTcxOTkwOTQ5M30.-1zneVMzdW3hZsaai7arkbtKz6dt0mCs6TArwkktKpA',
          roomName: 'Tezda Live',
          participantIdentity: 'Afrah Shaikh',
        ).then((val) {
          setState(() {
            livekitToken = val!.data!.token!;
          });
        });
      }

      //create new
      final room = Room();

      // Create a Listener before connecting
      final listener = room.createListener();

      // Try to connect to the room
      // This will throw an Exception if it fails for any reason.
      await room.connect(
        'wss://meet.tezda.me',
        livekitToken,
        roomOptions: const RoomOptions(
          adaptiveStream: true,
          dynacast: true,
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: true,
          ),
          defaultScreenShareCaptureOptions:
              ScreenShareCaptureOptions(useiOSBroadcastExtension: true),
        ),
        fastConnectOptions: FastConnectOptions(
          microphone: const TrackOption(enabled: true),
          camera: const TrackOption(enabled: true),
        ),
      );
       widget.timingObserver.startTiming();
      await Navigator.push<void>(
        ctx,

        MaterialPageRoute(builder: (_) => RoomPage(room, listener, isItVoiceCall,timingObserver: widget.timingObserver)),

      );
      
    } catch (error) {
      print('Could not connect $error');
      await ctx.showErrorDialog(error);
    } finally {
      setState(() {
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: SvgPicture.asset(
                      'images/logo-dark.svg',
                    ),
                  ),
                  const Text(
                    'Create The Call',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _busy
                              ? null
                              : () => _connect(context, true, true),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_busy)
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              const Text('Voice Call'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _busy
                              ? null
                              : () => _connect(context, true, false),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_busy)
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              const Text('Video Call'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Join The Call',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _busy
                              ? null
                              : () => _connect(context, false, true),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_busy)
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              const Text('Voice Call'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _busy
                              ? null
                              : () => _connect(context, false, false),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_busy)
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              const Text('Video Call'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
