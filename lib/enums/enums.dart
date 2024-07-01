// enum CallStatus {
//   calling,
//   ringing,
//   connecting,
//   connected;

//   String getValue() {
//     switch (this) {
//       case calling:
//         return 'Calling';
//       case ringing:
//         return 'Ringing';
//       case connecting:
//         return 'Connecting';
//       case connected:
//         return 'Connected';
//       default:
//         return 'Calling';
//     }
//   }
// }

enum CallNotificationStatus {
  userAcceptedCall,
  userDeclinedCall,
  callerEndedCall,
}

enum CallType { voiceCall, videoCall }

enum UserType { caller, acceptor }

enum SimulateScenarioResult {
  signalReconnect,
  fullReconnect,
  speakerUpdate,
  nodeFailure,
  migration,
  serverLeave,
  switchCandidate,
  e2eeKeyRatchet,
  participantName,
  participantMetadata,
  clear,
}
