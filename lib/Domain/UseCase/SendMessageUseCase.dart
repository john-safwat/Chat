import 'package:chat/Domain/Models/Message/Message.dart';
import 'package:chat/Domain/Repository/MessagesRepositoryContract.dart';

class SendMessageUseCase {

  MessagesRepository repository;
  SendMessageUseCase(this.repository);

  Future<void> invoke(Message message)async{
    await repository.sendMessage(message);
  }

}