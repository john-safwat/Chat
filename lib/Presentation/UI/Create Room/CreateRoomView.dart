import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomNavigator.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomViewModel.dart';
import 'package:flutter/material.dart';

class CreateRoomView extends StatefulWidget {
  const CreateRoomView({super.key});
  static const String routeName = "CreateRoom";
  @override
  State<CreateRoomView> createState() => _CreateRoomViewState();
}

class _CreateRoomViewState
    extends BaseState<CreateRoomView, CreateRoomViewModel>
    implements CreateRoomNavigator {
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
            title: Text(
              "Create Room",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: MyTheme.white),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width : double.infinity,
                    decoration: BoxDecoration(
                      color: MyTheme.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: MyTheme.black.withOpacity(0.3),
                          blurRadius: 10 ,
                          offset:const Offset(0, 5),
                        )
                      ]
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 30),
                        child: Column(
                          children: [
                            Text("Create New Room" , style: Theme.of(context).textTheme.displayLarge,),

                          ],
                        ),
                      ),
                    ),
                  )
                )
              ],
            ),
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
