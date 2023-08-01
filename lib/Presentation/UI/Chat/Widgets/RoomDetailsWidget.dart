import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class RoomDetailsWidget extends StatelessWidget {
  static const String routeName= 'roomDetails';
  Room room;
  RoomDetailsWidget(this.room, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Row(
           children: [
             const Text("Room name"),
             Text(room.name ,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: MyTheme.blue
              ),
             ),
           ],
         ),
         Row(
           children: [
             const Text("Room ID"),
             Text(room.id ,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: MyTheme.blue
              ),
             ),
           ],
         ),
         Row(
           children: [
             const Text("Room Description"),
             Text(room.description ,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: MyTheme.blue
              ),
             ),
           ],
         ),
         Row(
           children: [
             const Text("Room Category"),
             Text(room.category ,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: MyTheme.blue
              ),
             ),
           ],
         ),

      ],
    );
  }
}
