import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class CategoryDropdownButtonWidget extends StatelessWidget {
  RoomCategory category;
  CategoryDropdownButtonWidget({required this.category ,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/icons/${category.image}' , height: 40,),
          const SizedBox(width: 15,),
          Text(category.name ,style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.blue),)
        ],
    );
  }
}
