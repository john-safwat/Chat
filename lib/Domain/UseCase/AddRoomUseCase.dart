import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';
import 'package:chat/Domain/Repository/UsersRepositoryContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddRoomUseCase {
  RoomDataRepository repository ;
  UsersRepository usersRepository;
  AddRoomUseCase(this.repository , this.usersRepository);

  Future<String> invoke(String id , String name , String description , String category ,
      String type , String ownerId ,int dateTime , User user)async{
    var response  = await repository.addRoom(
        Room(
            id: id,
            name: name,
            description: description,
            category: category,
            type: type,
            ownerId: ownerId,
            users:[ownerId],
            dateTime: dateTime
        ));
    var userResponse = await usersRepository.addUser(response, Users(uid: user.uid, name: user.displayName!, email: user.email!, password: "unKnown"));
    return "Room Created Successfully";
  }

}