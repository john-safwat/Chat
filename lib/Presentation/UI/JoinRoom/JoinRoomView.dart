import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class JoinRoomScreen extends StatelessWidget {

  static const String routeName = 'JoinRoomScreen';
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: MyTheme.white,
      ),
      SizedBox(
        width: double.infinity,
        child: Image.asset(
          'assets/images/bgShape.png',
          fit: BoxFit.cover,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Join Room"),
        ),
      ),
      Container(
        child: const Column(
          children: [
            Text("Hello Welcome to Our Chat room"),
            Text("Join The ")
          ],
        ),
      )
    ]);
  }
}
