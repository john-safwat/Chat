import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Presentation/Base/BaseState.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Chat/ChatNavigator.dart';
import 'package:chat/Presentation/UI/Chat/ChatViewModel.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  static const String routeName = 'chatScreen';
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView , ChatViewModel> implements ChatNavigator{
  @override
  Widget build(BuildContext context) {
    Room room = ModalRoute.of(context)!.settings.arguments as Room;
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
            title: Text(room.name),
          ),
        )
      ],
    );
  }

  @override
  ChatViewModel initialViewModel() {
    return ChatViewModel();
  }
}
