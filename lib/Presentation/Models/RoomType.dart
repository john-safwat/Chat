import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';

class RoomType {
  IconData icon;
  String title;
  
  RoomType({required this.icon , required this.title});
  
  static List<RoomType> getTypesList (){
    return [
      RoomType(icon: EvaIcons.peopleOutline, title: "Public"),
      RoomType(icon: EvaIcons.lockOutline, title: "Private"),
    ];
  }

  static RoomType getRoomType(String id){
    var types = getTypesList();
    switch (id){
      case "Public":
        return types[0];
      case "Private":
        return types[1];
      default:
        return RoomType(icon: EvaIcons.peopleOutline, title: "Public") ;
    }
  }
}