import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';

class AddUserToRoomUseCase {

  RoomDataRepository repository;
  AddUserToRoomUseCase(this.repository);

  Future<String> invoke(String roomId , int membersNumber , String uid)async{
    var response = await repository.addRoomMember(roomId, membersNumber, uid);
    return response;
  }

}