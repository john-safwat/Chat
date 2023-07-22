class RoomDTO{

  String id;
  String name ;
  String description ;
  String category ;
  String type ;

  RoomDTO({
    required this.id ,
    required this.name,
    required this.description,
    required this.category,
    required this.type
  });

  RoomDTO.fromFireStore(Map<String , dynamic> json):this(
    id : json['id'],
    name : json ['name'],
    description: json['description'],
    category: json['category'],
    type: json['type']
  );

  Map<String , dynamic> toFireStore(){
    return {
      'id' : id ,
      'name' : name ,
      'description' : description ,
      'category' : category ,
      'type' : type ,
    };
  }

}