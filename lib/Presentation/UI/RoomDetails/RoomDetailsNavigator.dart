import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Models/User/Users.dart';

abstract class RoomDetailsNavigator extends BaseNavigator{
  showMyModalBottomSheetWidget(List<Users> users);
  goToUpdateRoomDetailsScreen(Room room);
}