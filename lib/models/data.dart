import 'enabled_codec.dart';

class Data {
  String? sid;
  String? name;
  int? emptyTimeout;
  int? maxParticipants;
  int? creationTime;
  String? turnPassword;
  List<EnabledCodec>? enabledCodecs;
  String? metadata;
  int? numParticipants;
  int? numPublishers;
  bool? activeRecording;
  String? token;

  Data({
    this.sid,
    this.name,
    this.emptyTimeout,
    this.maxParticipants,
    this.creationTime,
    this.turnPassword,
    this.enabledCodecs,
    this.metadata,
    this.numParticipants,
    this.numPublishers,
    this.activeRecording,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sid: json['sid'] as String?,
        name: json['name'] as String?,
        emptyTimeout: json['emptyTimeout'] as int?,
        maxParticipants: json['maxParticipants'] as int?,
        creationTime: json['creationTime'] as int?,
        turnPassword: json['turnPassword'] as String?,
        enabledCodecs: (json['enabledCodecs'] as List<dynamic>?)
            ?.map((e) => EnabledCodec.fromJson(e as Map<String, dynamic>))
            .toList(),
        metadata: json['metadata'] as String?,
        numParticipants: json['numParticipants'] as int?,
        numPublishers: json['numPublishers'] as int?,
        activeRecording: json['activeRecording'] as bool?,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'sid': sid,
        'name': name,
        'emptyTimeout': emptyTimeout,
        'maxParticipants': maxParticipants,
        'creationTime': creationTime,
        'turnPassword': turnPassword,
        'enabledCodecs': enabledCodecs?.map((e) => e.toJson()).toList(),
        'metadata': metadata,
        'numParticipants': numParticipants,
        'numPublishers': numPublishers,
        'activeRecording': activeRecording,
        'token': token,
      };
}
