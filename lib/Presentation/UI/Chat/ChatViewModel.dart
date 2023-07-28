import 'package:chat/Data/Models/Message/MessageDTO.dart';
import 'package:chat/Domain/Exception/FirebaseFireStoreDatabaseTimeoutException.dart';
import 'package:chat/Domain/Exception/FirebaseFirestoreDatabaseException.dart';
import 'package:chat/Domain/Models/Message/Message.dart';
import 'package:chat/Domain/UseCase/GetMessagesUseCase.dart';
import 'package:chat/Domain/UseCase/SendMessageUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/UI/Chat/ChatNavigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  SendMessageUseCase sendMessageUseCase;
  GetMessagesUseCase getMessagesUseCase;
  ChatViewModel(this.sendMessageUseCase , this.getMessagesUseCase);

  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();

  void sendMessage(String roomId) async {
    if (messageController.text.isNotEmpty){
      try {
        await sendMessageUseCase.invoke(Message(
            messageId: "",
            roomId: roomId,
            message: messageController.text,
            type: "Message",
            senderName: provider!.user!.displayName!,
            senderId: provider!.user!.uid,
            time: DateTime.now().millisecondsSinceEpoch));
        messageController.text ='';
      } catch (e) {
        if (e is FirebaseFireStoreDatabaseTimeoutException) {
          navigator!
              .showFailMessage(message: e.errorMessage, posActionTitle: "Ok");
        } else if (e is FirebaseFireStoreDatabaseException) {
          navigator!
              .showFailMessage(message: e.errorMessage, posActionTitle: "Ok");
        } else {
          navigator!.showFailMessage(message: e.toString(), posActionTitle: "Ok");
        }
      }
    }
  }

  Stream<QuerySnapshot<MessageDTO>> getMessages(String roomId){
    return getMessagesUseCase.invoke(roomId);
  }

  void sortMessagesByNewTime(){
    for(int i = 0 ; i< messages.length-1 ; i++){
      var swapped= false;
      for(int j = 0 ; j<messages.length - i -1 ; j++ ){
        if(messages[j].time < messages[j+1].time){
          var temp = messages[j];
          messages[j] = messages[j+1];
          messages[j+1] = temp;
          swapped = true;
        }
      }
      if (swapped == false) {
        break;
      }
    }
  }

}
