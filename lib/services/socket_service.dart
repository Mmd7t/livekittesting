// ignore: library_prefixes





import 'package:livekit_example/config/endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final IO.Socket _internal;
  IO.Socket get socket => _internal;
  SocketService({ required String userId }) : _internal = IO.io(EndPoints.socket(userId),{
    'autoConnect': true,
    'transports': ['websocket'],
  }){
    print("Inside constructor of Socket Service , userId : $userId");
    _internal.onConnect((data) => _log("Socket Connected"));
    _internal.onDisconnect((data) => _log("Socket Disconnected"));
    _log("Initiated Socket Service");
  }
  _log(String message){
    //Logger.logInfo(message, name: "ZEN_APP_SOCKET");
  }
}