import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:flutter/material.dart';

abstract class HomeNavigator extends BaseNavigator{
  goToSearchScreen();
  goToCreateRoomScreen();
  goToLoginScreen();
  goToJoinRoomScreen(Room room);
  goToChatScreen(Room room);
  showMyModalBottomSheet({required TextEditingController idController});
  hideModalBottomSheet();
}