import 'package:chat/Domain/Models/Message/Message.dart';

class MessageDTO {
  String messageId;
  String roomId;
  String message;
  String type;
  String senderName;
  String senderId;
  int time;

  MessageDTO({
    required this.messageId,
    required this.roomId,
    required this.message,
    required this.type,
    required this.senderName,
    required this.senderId,
    required this.time,
  });

  MessageDTO.fromFireStore(Map<String, dynamic> json)
      : this(
          messageId: json['messageId'],
          roomId: json['roomId'],
          message: json['message'],
          type: json['type'],
          senderName: json['senderName'],
          senderId: json['senderId'],
          time: json['time'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "messageId": messageId,
      "roomId": roomId,
      "message": message,
      "type": type,
      "senderName": senderName,
      "senderId": senderId,
      "time": time,
    };
  }

  Message toDomain() {
    return Message(
        messageId: messageId,
        roomId: roomId,
        message: message,
        type: type,
        senderName: senderName,
        senderId: senderId,
        time: time
    );
  }
}
