import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomNavigator.dart';

class CreateRoomViewModel extends BaseViewModel<CreateRoomNavigator>{

  void goToHomeScreen(){
    navigator!.goToHomeScreen();
  }
}