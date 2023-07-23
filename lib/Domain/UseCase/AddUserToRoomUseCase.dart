import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';

class AddUserToRoomUseCase {

  RoomDataRepository repository;
  AddUserToRoomUseCase(this.repository);

  Future<String> invoke(Room room , String uid)async{
    var response = await repository.addRoomMember(room.id,  uid);
    if(room.ownerId != uid){
      room.numberOfMembers++;
    }
    await repository.updateRoomData(room);
    return response;
  }

}