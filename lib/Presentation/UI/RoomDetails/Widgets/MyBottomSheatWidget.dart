import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Presentation/UI/RoomDetails/Widgets/WhiteSpaceWidget.dart';
import 'package:flutter/material.dart';

class MyBottomSheetWidget extends StatelessWidget {
  List<Users> users ;
  MyBottomSheetWidget({required this.users ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10 , vertical: 15),
      decoration: BoxDecoration(
          color: MyTheme.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Container(
                padding:const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                margin:const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: MyTheme.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0,2)
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(users[index].name , style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.blue , fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text(users[index].email , style: Theme.of(context).textTheme.displayMedium),
                  ],
                ),
              ),
              itemCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}
