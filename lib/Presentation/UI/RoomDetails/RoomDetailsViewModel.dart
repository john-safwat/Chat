import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/Models/Room/Room.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/UseCase/GetUsersListUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/Models/RoomCategory.dart';
import 'package:chat/Presentation/UI/RoomDetails/RoomDetailsNavigator.dart';

class RoomDetailsViewModel extends BaseViewModel<RoomDetailsNavigator>{
  GetUsersListUseCase useCase;
  RoomDetailsViewModel(this.useCase);
  Room? room;
  List<RoomCategory> categories = RoomCategory.getAllCategories();
  late RoomCategory selectedCategory;
  List<Users> users= [];
  String? errorMessage;

  void getUsersList()async{
    users = [];
    errorMessage = null;
    try{
        users = await useCase.invoke(roomId: room!.id);
        notifyListeners();
    }catch (e){

      if(e is FirebaseAuthRemoteDataSourceException){
          errorMessage = e.errorMessage;
      }else if (e is FirebaseAuthTimeoutException){
          errorMessage = e.errorMessage;
      }else{
        errorMessage = e.toString();
      }
      notifyListeners();
    }
  }
}