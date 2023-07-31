import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';

class DeleteRoomUseCase {

  RoomDataRepository repository ;
  DeleteRoomUseCase(this.repository);

  Future<String> invoke (String roomId)async{
    var response = await repository.deleteRoom(roomId);
    return response;
  }

}