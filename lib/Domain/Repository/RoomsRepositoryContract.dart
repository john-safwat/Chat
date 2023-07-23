import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RoomDataRemoteDataSource {
  Future<String> addRoom(RoomDTO room);
  Stream<QuerySnapshot<RoomDTO>>getPublicRooms();
  Future<String> addRoomMember(String roomId , String uid);
  Future<void> updateRoomData(RoomDTO room);
}

abstract class RoomDataRepository{
  Future<String> addRoom(Room room);
  Stream<QuerySnapshot<RoomDTO>>getPublicRooms();
  Future<String> addRoomMember(String roomId , String uid);
  Future<void> updateRoomData(Room room);
}