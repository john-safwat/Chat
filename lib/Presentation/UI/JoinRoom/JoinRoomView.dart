import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/UseCase/AddUserToRoomUseCase.dart';
import 'package:chat/Presentation/DI/di.dart';
import 'package:chat/Presentation/UI/Chat/ChatView.dart';
import 'package:chat/Presentation/UI/JoinRoom/JoinRoomNavigator.dart';
import 'package:chat/Presentation/UI/JoinRoom/JoinRoomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinRoomScreen extends StatefulWidget {
  static const String routeName = 'JoinRoomScreen';

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends BaseState<JoinRoomScreen, JoinRoomViewModel>
    implements JoinRoomNavigator {
  Room? room ;

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)!.settings.arguments as Room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: MyTheme.white,
        ),
        Image.asset(
          'assets/images/bgShape.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Join Room"),
          ),
          body: Column(
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: MyTheme.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: MyTheme.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5))
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hello, Welcome to our chat room",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Join ${room!.name}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          child: Image.asset(
                            "assets/icons/${room!.category}.png",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          room!.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: MyTheme.black.withOpacity(0.6)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              viewModel!.joinRoom(room!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                "Join",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: MyTheme.white),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ]),
    );
  }

  @override
  JoinRoomViewModel initialViewModel() {
    return JoinRoomViewModel(AddUserToRoomUseCase(injectRoomDataRepo() , injectUserRepo()));
  }

  @override
  goToChatRoom() {
    Navigator.pushReplacementNamed(context, ChatView.routeName , arguments: room!);
  }
}
