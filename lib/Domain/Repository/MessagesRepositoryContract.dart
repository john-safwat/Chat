import 'package:chat/Data/Models/Message/MessageDTO.dart';
import 'package:chat/Domain/Models/Message/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessagesRemoteDataSource {
  Future<void> sendMessage(MessageDTO message);
  Stream<QuerySnapshot<MessageDTO>> getMessages(String roomId);
}

abstract class MessagesRepository {
  Future<void> sendMessage(Message message);
  Stream<QuerySnapshot<MessageDTO>> getMessages(String roomId);
}