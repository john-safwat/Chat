import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Models/Room/Room.dart';

abstract class RoomDataRemoteDataSource {
  Future<String> addRoom(RoomDTO room);

}

abstract class RoomDataRepository{
  Future<String> addRoom(Room room);

}