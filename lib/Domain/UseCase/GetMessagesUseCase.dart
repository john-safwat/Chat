import 'package:chat/Data/Models/Message/MessageDTO.dart';
import 'package:chat/Domain/Repository/MessagesRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessagesUseCase{
  MessagesRepository repository ;
  GetMessagesUseCase(this.repository);

  Stream<QuerySnapshot<MessageDTO>> invoke(String roomId){
    return repository.getMessages(roomId);
  }


}