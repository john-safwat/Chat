import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Presentation/Base/BaseNavigator.dart';

abstract class SearchNavigator extends BaseNavigator{

  goToJoinRoomScreen(Room room);
  goToChatScreen(Room room);
}