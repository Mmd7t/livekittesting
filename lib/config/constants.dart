import 'package:uuid/uuid.dart';

class Constants {
  static const String baseUrl = 'https://api.tezda.tech/video/t';
  static const String notificationsBaseUrl =
      'https://szg7o6k9d0.execute-api.us-east-1.amazonaws.com/dev//notification';
  static const String notificationSocketUrl = 'https://wss.tezda.me';
  static const String xApiKey = '2p5kmXzhWraxSJ6pZ5h5q9Y120BiFY6b4yvNinx4';
  static const String notificationsXApiKey =
      'IwtpuwQN0a8kxOggRYK8X9WpmGCXf5pW9Fznj4O8';
  static String logHeader = 'Zen V-Call';
}

String currentUuid = const Uuid().v4();
