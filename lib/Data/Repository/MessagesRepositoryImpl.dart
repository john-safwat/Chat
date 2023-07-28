import 'package:chat/Data/Models/Message/MessageDTO.dart';
import 'package:chat/Domain/Models/Message/Message.dart';
import 'package:chat/Domain/Repository/MessagesRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesRepositoryImpl implements MessagesRepository{
  MessagesRemoteDataSource dataSource ;
  MessagesRepositoryImpl(this.dataSource);

  @override
  Future<void> sendMessage(Message message) async{
    await dataSource.sendMessage(message.toDataSource());
  }

  @override
  Stream<QuerySnapshot<MessageDTO>> getMessages(String roomId) {
    return dataSource.getMessages(roomId);
  }
}