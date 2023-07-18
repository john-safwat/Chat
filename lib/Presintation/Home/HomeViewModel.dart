import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Presintation/Home/HomeNavigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{

  void goToSearchScreen(){
    navigator!.goToSearchScreen();
  }


  void goToCreateRoomScreen(){
    navigator!.goToCreateRoomScreen();
  }
}