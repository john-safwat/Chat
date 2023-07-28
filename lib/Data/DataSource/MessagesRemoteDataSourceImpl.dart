import 'dart:async';

import 'package:chat/Data/Firebase/ErrorHandeler.dart';
import 'package:chat/Data/Firebase/MessagesDatabase.dart';
import 'package:chat/Data/Models/Message/MessageDTO.dart';
import 'package:chat/Domain/Exception/FirebaseFireStoreDatabaseTimeoutException.dart';
import 'package:chat/Domain/Exception/FirebaseFirestoreDatabaseException.dart';
import 'package:chat/Domain/Repository/MessagesRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource{
  MessagesDatabase database;
  ErrorHandler errorHandler;
  MessagesRemoteDataSourceImpl(this.database , this.errorHandler);

  @override
  Future<void> sendMessage(MessageDTO message) async{
    try{
      await database.sendMessage(message);
    }on FirebaseException catch(e){
      var error = errorHandler.handleFirebaseFireStoreError(e.code);
      throw FirebaseFireStoreDatabaseException(error);
    }on TimeoutException catch(e){
      throw FirebaseFireStoreDatabaseTimeoutException("This Operation Has Timed Out");
    }catch (e){
      throw FirebaseFireStoreDatabaseException("UnKnown Error");
    }
  }

  @override
  Stream<QuerySnapshot<MessageDTO>> getMessages(String roomId) {
    return database.getRoomMessages(roomId);
  }
}