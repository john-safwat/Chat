import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/UI/Search/SearchNavigator.dart';

class SearchViewModel extends BaseViewModel<SearchNavigator>{


  void goToHomeScreen(){
    navigator!.goToHomeScreen();
  }
}