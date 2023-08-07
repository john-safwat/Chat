import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Domain/Exception/FirebaseFireStoreDatabaseTimeoutException.dart';
import 'package:chat/Domain/Exception/FirebaseFirestoreDatabaseException.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/UseCase/SearchForRoomsUseCase.dart';
import 'package:chat/Presentation/UI/Search/SearchNavigator.dart';

class SearchViewModel extends BaseViewModel<SearchNavigator>{

  SearchForRoomsUseCase searchForRoomsUseCase;
  SearchViewModel(this.searchForRoomsUseCase);

  List<Room> rooms = [];
  String? errorMessage ;

  late String uid =  provider!.user!.uid;

  void goToHomeScreen(){
    navigator!.removeContext();
  }

  void search(String query)async{
    try{
      var response = await searchForRoomsUseCase.invoke(query);
      rooms =response;
    }catch(e){
      navigator!.removeContext();
      if (e is FirebaseFireStoreDatabaseTimeoutException){
        errorMessage = e.errorMessage;
      }else if (e is FirebaseFireStoreDatabaseException){
        errorMessage = e.errorMessage;
      }else {
        errorMessage = e.toString();
      }
    }
    notifyListeners();
  }

  void goToJoinRoomScreen(Room room){
    navigator!.goToJoinRoomScreen(room);
  }
  void goToChatScreen(Room room){
    navigator!.goToChatScreen(room);
  }
}