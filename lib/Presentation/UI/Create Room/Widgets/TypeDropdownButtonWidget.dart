import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presentation/Models/RoomType.dart';
import 'package:flutter/material.dart';

class TypeDropdownButtonWidget extends StatelessWidget {

  RoomType roomType;
  TypeDropdownButtonWidget({required this.roomType ,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(roomType.icon ,color: MyTheme.blue,),
        const SizedBox(width: 10,),
        Text(roomType.title , style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.blue),),
      ],
    );
  }
}
