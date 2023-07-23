import 'dart:async';

import 'package:chat/Data/Firebase/RoomsDatabase.dart';
import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Exception/FirebaseFireStoreDatabaseTimeoutException.dart';
import 'package:chat/Domain/Exception/FirebaseFirestoreDatabaseException.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDataRemoteDataSourceImpl implements RoomDataRemoteDataSource{
  RoomsDatabase database;
  RoomDataRemoteDataSourceImpl(this.database);

  @override
  Future<String> addRoom(RoomDTO room) async {
    try{
      await database.addRoom(room).timeout(const Duration(seconds: 15));
      return "Room Created Successfully";
    }on FirebaseException catch(e){
      String error = '';
      switch (e.code) {
        case "ABORTED":
          error = "The operation was aborted, typically due to a concurrency issue like transaction aborts, etc.";
          break;
        case "ALREADY_EXISTS":
          error = "Some document that we attempted to create already exists.";
          break;
        case "CANCELLED":
          error = "The operation was cancelled (typically by the caller).";
          break;
        case "DATA_LOSS":
          error = 'Unrecoverable data loss or corruption.';
          break;
        case "DEADLINE_EXCEEDED":
          error = "Deadline expired before operation could complete.";
          break;
        case "FAILED_PRECONDITION":
          error = "Operation was rejected because the system is not in a state required for the operation's execution.";
          break;
        case "INTERNAL":
          error = "Internal errors.";
          break;
        case "INVALID_ARGUMENT":
          error = "Client specified an invalid argument.";
          break;
        case "NOT_FOUND":
          error = "Some requested document was not found.";
          break;
        case "OK":
          error = "The operation completed successfully.";
          break;
        case "OUT_OF_RANGE":
          error = "Operation was attempted past the valid range.";
          break;
        case "PERMISSION_DENIED":
          error = "The caller does not have permission to execute the specified operation.";
          break;
        case "RESOURCE_EXHAUSTED":
          error = "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.";
          break;
        case "UNAUTHENTICATED":
          error = "The request does not have valid authentication credentials for the operation.";
          break;
        case "UNAVAILABLE":
          error = "The service is currently unavailable.";
          break;
        case "UNIMPLEMENTED":
          error = "Operation is not implemented or not supported/enabled.";
          break;
        case "UNKNOWN":
          error = "Unknown error or an error from a different error domain.";
          break;
        default:
          error = "Some Thing Went Wrong";
          break;
      }
      throw FirebaseFireStoreDatabaseException(error);
    }on TimeoutException catch(e){
      throw FirebaseFireStoreDatabaseTimeoutException("This Operation Has Timed Out");
    }catch (e){
      throw FirebaseFireStoreDatabaseException("UnKnown Error");
    }
  }
}