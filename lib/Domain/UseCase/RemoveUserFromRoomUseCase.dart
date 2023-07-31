import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';

class RemoveUserFromRoomUseCase {

  RoomDataRepository repository;
  RemoveUserFromRoomUseCase(this.repository);

  Future<String> invoke(Room room , String uid)async{
    room.users.removeWhere((element) => element == uid);
    await repository.updateRoomMembers(room);
    return "You Are No Longer Allowed to view This Room";
  }

}