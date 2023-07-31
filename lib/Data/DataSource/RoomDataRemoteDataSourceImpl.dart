import 'dart:async';
import 'package:chat/Data/Firebase/ErrorHandeler.dart';
import 'package:chat/Data/Firebase/RoomsDatabase.dart';
import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Exception/FirebaseFireStoreDatabaseTimeoutException.dart';
import 'package:chat/Domain/Exception/FirebaseFirestoreDatabaseException.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDataRemoteDataSourceImpl implements RoomDataRemoteDataSource{
  RoomsDatabase database;
  ErrorHandler errorHandler;
  RoomDataRemoteDataSourceImpl(this.database , this.errorHandler);

  @override
  Future<String> addRoom(RoomDTO room) async {
    try{
      await database.addRoom(room).timeout(const Duration(seconds: 15));
      return "Room Created Successfully";
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
  Stream<QuerySnapshot<RoomDTO>> getPublicRooms() {
    return database.getPublicRooms();
  }

  @override
  Future<String> updateRoomMembers(RoomDTO room) async{
    try{
      await database.updateRoomData(room).timeout(const Duration(seconds: 15));
      return "Welcome\nYou Joint Successfully";
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
  Stream<QuerySnapshot<RoomDTO>> getUserRooms(String uid) {
    return database.getUserRooms(uid);
  }

  @override
  Future<Room> getRoomById(String roomId) async{
    try{
      var response  = await database.getRoomById(roomId);
      return response.toDomain();
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
  Future<List<Room>> getRoomsForSearch(String query) async{
    try{
      var response  = await database.getSearchRooms(query);
      return response.map((e) => e.toDomain()).toList();
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
  Future<String> deleteRoom(String roomId)async {
    try{
      await database.deleteRoom(roomId);
      return "Room Deleted successfully";
    }on FirebaseException catch(e){
      var error = errorHandler.handleFirebaseFireStoreError(e.code);
      throw FirebaseFireStoreDatabaseException(error);
    }on TimeoutException catch(e){
      throw FirebaseFireStoreDatabaseTimeoutException("This Operation Has Timed Out");
    }catch (e){
      throw FirebaseFireStoreDatabaseException("UnKnown Error");
    }
  }

}