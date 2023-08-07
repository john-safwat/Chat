import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Domain/Models/Room/Room.dart';

abstract class SearchNavigator extends BaseNavigator{

  goToJoinRoomScreen(Room room);
  goToChatScreen(Room room);
}