import 'package:chat/Data/Models/Message/MessageDTO.dart';

class Message {
  String messageId;
  String roomId;
  String message;
  String type;
  String senderName;
  String senderId;
  int time;

  Message({
    required this.messageId,
    required this.roomId,
    required this.message,
    required this.type,
    required this.senderName,
    required this.senderId,
    required this.time,
  });

  MessageDTO toDataSource() {
    return MessageDTO(
        messageId: messageId,
        roomId: roomId,
        message: message,
        type: type,
        senderName: senderName,
        senderId: senderId,
        time: time);
  }
}
