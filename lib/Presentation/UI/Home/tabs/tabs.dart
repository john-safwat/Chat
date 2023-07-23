import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Home/HomeViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tabs extends StatelessWidget {
  Stream<QuerySnapshot<RoomDTO>> rooms;
  Tabs(this.rooms);
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeViewModel>(context);
    return Expanded(
      child: StreamBuilder<QuerySnapshot<RoomDTO>>(
        stream: rooms,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: MyTheme.blue,));
          }else if(snapshot.hasError){
              return const Center(child: Text("Can't load data"));
          }else{
            List<Room> roomsList = snapshot.data!.docs.map((e) => e.data().toPresentation()).toList();
            return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            padding: const EdgeInsets.all(20),
            itemCount: roomsList.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: MyTheme.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0,5)
                  )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
              child: InkWell(
                onTap: (){
                  viewModel.goTOJoinRoomScreen();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/icons/${roomsList[index].category}.png",
                      height: 80,
                    ),
                    Text(
                      roomsList[index].name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      roomsList[index].numberOfMembers.toString(),
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
              ),
            ),
          );
         }
        }
      ),
    );
  }
}
