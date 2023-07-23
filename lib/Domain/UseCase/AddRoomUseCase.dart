import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Repository/RoomsRepositoryContract.dart';

class AddRoomUseCase {
  RoomDataRepository repository ;
  AddRoomUseCase(this.repository);

  Future<String> invoke(String id , String name , String description , String category ,
      String type , String ownerId)async{
    var response  = await repository.addRoom(
        Room(
            id: id,
            name: name,
            description: description,
            category: category,
            type: type,
            ownerId: ownerId,
        ));
    return response;
  }

}