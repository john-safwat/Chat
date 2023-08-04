import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:chat/Domain/Repository/UsersRepositoryContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddUserToRoomByRoomIdUseCase {
  RoomDataRepository repository ;
  UsersRepository usersRepository;
  AddUserToRoomByRoomIdUseCase(this.repository , this.usersRepository);


  Future<String> invoke(String roomId , User user)async{
    var room = await repository.getRoomById(roomId);
    if(room.users.contains(user.uid)){
      return "You Are Already in This Room";
    }else {
      room.users.add(user.uid);
      var response = await repository.updateRoomMembers(room);
      var userResponse = await usersRepository.addUser(roomId, Users(uid: user.uid, name: user.displayName!, email: user.email!, password: "unKnown"));
      return response;
    }
  }

}