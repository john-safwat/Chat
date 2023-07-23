import 'package:chat/Data/Models/Room/RoomDTO.dart';

class Room {
  String id;
  String name;
  String description;
  String category;
  String type;
  String ownerId;
  int numberOfMembers;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.type,
    required this.ownerId,
    this.numberOfMembers = 1
  });

  RoomDTO toDataSource() {
    return RoomDTO(
       id: id,
       name: name,
       description: description,
       category: category,
       type: type,
       ownerId:ownerId,
       numberOfMembers: numberOfMembers
    );
  }
}
