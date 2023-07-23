import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDataRepositoryImpl implements RoomDataRepository{

  RoomDataRemoteDataSource dataSource ;
  RoomDataRepositoryImpl(this.dataSource);

  @override
  Future<String> addRoom(Room room) async{
    var response = await dataSource.addRoom(room.toDataSource());
    return response;
  }

  @override
  Stream<QuerySnapshot<RoomDTO>> getPublicRooms() {
    return dataSource.getPublicRooms();
  }

  @override
  Future<String> addRoomMember(String roomId, String uid) async{
    var response = await dataSource.addRoomMember(roomId, uid);
    return response;
  }

  @override
  Future<void> updateRoomData(Room room) async{
    await dataSource.updateRoomData(room.toDataSource());
  }

}