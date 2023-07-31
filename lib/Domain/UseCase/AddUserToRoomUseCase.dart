import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';

class AddUserToRoomUseCase {

  RoomDataRepository repository;
  AddUserToRoomUseCase(this.repository);

  Future<String> invoke(Room room , String uid)async{
    room.users.add(uid);
    var response = await repository.updateRoomMembers(room);
    return response;
  }

}