import 'package:chat/Data/Models/Room/RoomDTO.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Home/HomeViewModel.dart';
import 'package:chat/Presentation/UI/GlobalWidgets/CardWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRoomsTab extends StatelessWidget {
  Stream<QuerySnapshot<RoomDTO>> rooms;
  Function navigate;
  MyRoomsTab(this.rooms, this.navigate);
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
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
              viewModel.myRooms = snapshot.data!.docs.map((e) => e.data().toDomain()).toList();
              if (viewModel.myRooms.isEmpty) {
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
                  itemCount: viewModel.myRooms.length,
                  itemBuilder: (context, index) => CardWidget(room: viewModel.myRooms[index], navigate: navigate),
                );
              }
            }
          }),
    );
  }
}
