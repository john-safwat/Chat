import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:chat/Domain/Repository/UsersRepositoryContract.dart';

class RemoveUserFromRoomUseCase {

  RoomDataRepository repository;
  UsersRepository usersRepository;
  RemoveUserFromRoomUseCase(this.repository , this.usersRepository);

  Future<String> invoke(Room room , String uid)async{
    room.users.removeWhere((element) => element == uid);
    await repository.updateRoomMembers(room);
    await usersRepository.removeUser(room.id, uid);
    return "You Are No Longer Allowed to view This Room";
  }

}