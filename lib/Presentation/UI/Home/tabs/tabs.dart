import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Home/HomeViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tabs extends StatelessWidget {
  Stream<QuerySnapshot<RoomDTO>> rooms;
  Function goToJoinRoomScreen;
  Tabs(this.rooms, this.goToJoinRoomScreen);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot<RoomDTO>>(
          stream: rooms,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: MyTheme.blue,
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text("Can't load data"));
            } else {
              List<Room> roomsList =
                  snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
              if (roomsList.isEmpty) {
                return Center(
                  child: Text(
                    "There Is No Rooms Yet",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: MyTheme.blue, fontWeight: FontWeight.w500),
                  ),
                );
              } else {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.77),
                  padding: const EdgeInsets.all(20),
                  itemCount: roomsList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      goToJoinRoomScreen(roomsList[index]);
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
                                "assets/icons/${roomsList[index].category}.png",
                                height: 80,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                roomsList[index].name,
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
                              roomsList[index].type == 'Public'
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
                                  "${roomsList[index].numberOfMembers.toString()} Member",
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
                  ),
                );
              }
            }
          }),
    );
  }
}
