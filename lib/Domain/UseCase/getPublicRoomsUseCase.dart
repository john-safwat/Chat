import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetPublicRoomsUseCase{
  RoomDataRepository repository;
  GetPublicRoomsUseCase(this.repository);

  Stream<QuerySnapshot<RoomDTO>> invoke(){
    return repository.getPublicRooms();
  }
}