import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/UseCase/SignOutUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/Providers/AppConfigProvider.dart';
import 'package:chat/Presentation/UI/Home/HomeNavigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator>{

  SignOutUseCase signOutUseCase;
  HomeViewModel(this.signOutUseCase);


  void goToSearchScreen(){
    navigator!.goToSearchScreen();
  }

  void goToCreateRoomScreen(){
    navigator!.goToCreateRoomScreen();
  }

  void onSignOutPress()async{
    navigator!.showQuestionMessage(message: "Are You Sure ?" , posActionTitle: "Ok" , posAction: signOut , negativeActionTitle: "Cancel");
  }

  void signOut()async{
    navigator!.showLoading("Logging You out");
    try{
      var response = await signOutUseCase.invoke();
      provider!.removeUser();
      navigator!.removeContext();
      navigator!.goToLoginScreen();
    }catch (e){
      navigator!.removeContext();
      if(e is FirebaseAuthRemoteDataSourceException){
        navigator!.showFailMessage(message: e.errorMessage , posActionTitle: "Try Again");
      }else if (e is FirebaseAuthTimeoutException){
        navigator!.showFailMessage(message: e.errorMessage , posActionTitle: "Try Again");
      }else{
        navigator!.showFailMessage(message: e.toString(), posActionTitle: "Try Again");
      }
    }
  }
}