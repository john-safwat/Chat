import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Presintation/Create%20Room/CreateRoomNavigator.dart';

class CreateRoomViewModel extends BaseViewModel<CreateRoomNavigator>{

  void goToHomeScreen(){
    navigator!.goToHomeScreen();
  }
}