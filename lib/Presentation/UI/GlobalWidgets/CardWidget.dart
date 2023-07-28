import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  Function navigate;
  Room room;
  CardWidget({required this.room , required this.navigate , super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(room);
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: MyTheme.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/${room.category}.png",
                  height: 80,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  room.name,
                  textAlign: TextAlign.center,
                  maxLines:3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
          Container(
              margin:const EdgeInsets.all(0),
              padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
              decoration: const BoxDecoration(
                color: MyTheme.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  room.type == 'Public'
                      ? const Icon(
                    EvaIcons.peopleOutline,
                    color: MyTheme.white,
                  )
                      : const Icon(
                    EvaIcons.lockOutline,
                    color: MyTheme.white,
                  ),
                  Expanded(
                    child: Text(
                      "${room.users.length} Member",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
