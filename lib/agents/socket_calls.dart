import 'dart:developer';
import 'package:livekit_example/config/constants.dart';
import 'package:livekit_example/enums/enums.dart';
import 'package:socket_io_client/socket_io_client.dart';



class SocketCalls {
  static sendCallNotification({
    required String roomId,
    required String callerId,
    required String callerName,
    required String callerUserName,
    required String callerUserAvatar,
    required CallType callType,
    required List<String> receiverIds,
    required Socket sc,
  }) async {
    final data = {
      "roomId": roomId,
      "userId": callerId,
      "callType": callType == CallType.voiceCall ? 'voice-call' : 'video-call',
      "notificationType": "data",
      "recieverIds": receiverIds,
      "notificationId": roomId,
      "name": callerName,
      "userName": callerUserName,
      "userAvatar": callerUserAvatar,
      "callStatus":
          callType == CallType.voiceCall ? 'voice-call' : 'video-call',
    };
    try {
      log("socket active :: ${sc.active}");
      log("socket connected :: ${sc.connected}");
      log("socket disconnected :: ${sc.disconnected}");
      // sc.connect();
      // log("socket disconnected :: ${sc.connect()}");
      sc.emit("call_notification", data);
      log('Caller is sending call notification', name: Constants.logHeader);
    } catch (e) {
      log("Socket Issue : ${e.toString()}");
    }
  }

  static confirmNotificationReceived({
    required String roomId,
    required String userId,
    required Socket sc,
  }) async {
    final data = {"userID": userId, "roomId": roomId};
    try {
      sc.emit("confirm_notification", data);
      log('Other user received the call', name: Constants.logHeader);
    } catch (e) {
      log(e.toString());
    }
  }

  static acceptCall({
    required String roomId,
    required String userId,
    required Socket sc,
  }) async {
    final data = {"userID": userId, "roomID": roomId};
    try {
      sc.emit("accept_call", data);
      log('User accept the call', name: Constants.logHeader);
    } catch (e) {
      log(e.toString());
    }
  }

  static rejectCall({
    required String roomId,
    required String userId,
    required Socket sc,
  }) async {
    final data = {"userID": userId, "roomID": roomId};
    try {
      sc.emit("reject_call", data);
      log('User reject the call', name: Constants.logHeader);
    } catch (e) {
      log(e.toString());
    }
  }

  static cancelCall({
    required String roomId,
    required String userId,
    required Socket sc,
  }) async {
    final data = {"userID": userId, "roomID": roomId};
    try {
      sc.emit("cancel_call", data);
      log('User A cancelled the call', name: Constants.logHeader);
    } catch (e) {
      log(e.toString());
    }
  }
}
