import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:livekit_example/config/constants.dart';
import 'package:livekit_example/config/dio_helper.dart';
import 'package:livekit_example/models/access_token_model.dart';

class ApiCalls {
  static Dio dio = DioHelper().dio;

  // room id ABC  (Medhat/Afrah)
  // room id ABC  (Medhat/Afrah)

  //SECTION -------------------> CREATE ROOM REQUEST
  static Future<AccessTokenModel?> createRoom(
      {required String authToken,
      required String roomName,
      required String participantIdentity}) async {
         final starttime = DateTime.now();
    Response res = await dio.post(
      '/generateTokenForRoom',
      data: {
        'RoomName': roomName,
        'MaxParticipants': 10,
        'ParticipantIdentity': participantIdentity
      },
      options: Options(headers: {'Authorization': authToken}),
    );
      final endtime=DateTime.now();
    final duration = starttime.difference(endtime);
    print('Time taken for createroom ${duration.inSeconds} secs');
    if (res.statusCode != 201) {
      return null;
    } else {
      return AccessTokenModel.fromJson(res.data);
    }
  }

  //SECTION -------------------> GENERATE LK ACCESS TOKEN REQUEST
  static Future<AccessTokenModel?> generateLKAccessToken(
      {required String authToken,
      required String roomName,
      required String participantIdentity}) async {
    log('Start Generating');
    final starttime = DateTime.now();
    Response res = await dio.post(
      '/generateLKToken',
      data: {
        'RoomName': roomName,
        'ParticipantIdentity': participantIdentity,
      },
      options: Options(headers: {'Authorization': authToken}),
    );
    final endtime=DateTime.now();
    final duration = starttime.difference(endtime);
    print('Time taken for generatelktoken ${duration.inSeconds} secs');
    if (res.statusCode != 201) {
      log('Generate LK Access Token ${res.statusCode}');
      log('Generate LK Access Token ${res.data}');
      return null;
    } else {
      log('Generate LK Access Token Data ${res.data}');
      return AccessTokenModel.fromJson(res.data);
    }
  }

  //SECTION -------------------> DELETE ROOM REQUEST
  static Future<bool> deleteRoom({
    required String authToken,
    required String roomName,
  }) async {
    Response res = await dio.post(
      '/deleteRoom',
      data: {'RoomName': roomName},
      options: Options(headers: {'Authorization': authToken}),
    );
    if (res.statusCode != 204) {
      return false;
    } else {
      return true;
    }
  }

  //SECTION -------------------> CONFIRM NOTIFICATION REQUEST
  static Future<bool> confirmNotification({
    required String roomId,
    required String userId,
  }) async {
    Response res = await dio.postUri(
      Uri.parse('${Constants.notificationSocketUrl}/confirmNotification'),
      data: {
        'roomID': roomId,
        'userID': userId,
      },
      options: Options(headers: {'x-api-key': Constants.notificationsXApiKey}),
    );
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  //SECTION -------------------> ACCEPT CALL NOTIFICATION REQUEST
  static Future<bool> acceptCallNotification({
    required String roomId,
    required String userId,
  }) async {
    Response res = await dio.postUri(
      Uri.parse('${Constants.notificationSocketUrl}/acceptCall'),
      data: {
        'roomID': roomId,
        'userID': userId,
      },
      options: Options(headers: {'x-api-key': Constants.notificationsXApiKey}),
    );
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  //SECTION -------------------> REJECT CALL NOTIFICATION REQUEST
  static Future<bool> rejectCallNotification({
    required String roomId,
    required String userId,
  }) async {
    Response res = await dio.postUri(
      Uri.parse('${Constants.notificationSocketUrl}/rejectCall'),
      data: {
        'roomID': roomId,
        'userID': userId,
      },
      options: Options(headers: {'x-api-key': Constants.notificationsXApiKey}),
    );
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
