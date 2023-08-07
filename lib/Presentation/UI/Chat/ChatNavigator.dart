import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Domain/Models/Room/Room.dart';

abstract class ChatNavigator extends BaseNavigator{
  goToRoomDetailsScreen(Room room);
}