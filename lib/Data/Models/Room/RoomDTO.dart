import 'package:chat/Domain/Models/Room/Room.dart';

class RoomDTO{

  String id;
  String name ;
  String description ;
  String category ;
  String type ;
  String ownerId;
  int numberOfMembers;

  RoomDTO({
    required this.id ,
    required this.name,
    required this.description,
    required this.category,
    required this.type,
    required this.ownerId,
    required this.numberOfMembers
  });

  RoomDTO.fromFireStore(Map<String , dynamic> json):this(
    id : json['id'],
    name : json ['name'],
    description: json['description'],
    category: json['category'],
    type: json['type'],
    ownerId: json['ownerId'],
    numberOfMembers: json['numberOfMembers']
  );

  Map<String , dynamic> toFireStore(){
    return {
      'id' : id ,
      'name' : name ,
      'description' : description ,
      'category' : category ,
      'type' : type ,
      'ownerId' : ownerId,
      'numberOfMembers' : numberOfMembers
    };
  }

  Room toPresentation(){
    return Room(id: id, name: name, description: description, category: category, type: type, ownerId: ownerId);
  }

}