import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';

class AddUserToRoomByRoomIdUseCase {
  RoomDataRepository repository ;
  AddUserToRoomByRoomIdUseCase(this.repository);


  Future<String> invoke(String roomId , String uid)async{
    var room = await repository.getRoomById(roomId);
    if(room.users.contains(uid)){
      return "You Are Already in This Room";
    }else {
      room.users.add(uid);
      var response = await repository.addRoomMember(room);
      return response;
    }
  }

}