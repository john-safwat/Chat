import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserRoomsUseCase {

  RoomDataRepository repository;
  GetUserRoomsUseCase(this.repository);

  Stream<QuerySnapshot<RoomDTO>> invoke(String uid){
    return repository.getUserRooms(uid);
  }

}