import 'package:chat/Presentation/Base/BaseNavigator.dart';

abstract class HomeNavigator extends BaseNavigator{
  goToSearchScreen();
  goToCreateRoomScreen();
  goToLoginScreen();
}