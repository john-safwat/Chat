import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presintation/Create%20Room/CreateRoomNavigator.dart';
import 'package:chat/Presintation/Create%20Room/CreateRoomViewModel.dart';
import 'package:flutter/material.dart';

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({super.key});
  static const String routeName = "CreateRoom";
  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState extends BaseState<CreateRoomView , CreateRoomViewModel> implements CreateRoomNavigator{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
          appBar: AppBar(
            title: Text("Create Room" , style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.white),),
          ),
        ),
      ],
    );
  }

  @override
  CreateRoomViewModel initialViewModel() {
    return CreateRoomViewModel();
  }

  @override
  goToHomeScreen() {
    Navigator.pop(context);
  }
}
