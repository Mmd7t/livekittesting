import 'package:livekit_client/livekit_client.dart';

class ParticipantTrack {
  ParticipantTrack({
    required this.participant,
    required this.videoTrack,
  });
  VideoTrack? videoTrack;
  Participant participant;
}
