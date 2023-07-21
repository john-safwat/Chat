import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/UseCase/LoginAccountUseCase.dart';
import 'package:chat/Domain/UseCase/SignInWithGoogleUseCase.dart';
import 'package:chat/Presentation/Base/BaseViewModel.dart';
import 'package:chat/Presentation/Providers/AppConfigProvider.dart';
import 'package:chat/Presentation/UI/Login/LoginNavigator.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  LoginAccountUseCase loginAccountUseCase;
  SignInWithGoogleUseCase signInWithGoogleUseCase;
  LoginViewModel(this.loginAccountUseCase , this.signInWithGoogleUseCase);

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AppConfigProvider? provider ;

  // validate on the name if it is not empty and doesn't contain ant spacial characters
  // validate on the email form
  String? emailValidation(String input) {
    if (input.isEmpty) {
      return "The Email Can't Be Empty";
    } else if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+"
    r"@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(input)) {
      return "Please Enter A Valid Email";
    }
    return null;
  }
  // validate the password is not less than 8 chars
  String? passwordValidation(String input) {
    if (input.isEmpty) {
      return "The Password Can't Be Empty";
    } else if (input.length < 8) {
      return "The Password Must be More Than 8 Characters";
    }
    return null;
  }

  // login with email and password
  void login()async{
    if(formKey.currentState!.validate()){
      navigator!.showLoading("Logging In");
      try{
        var response = await loginAccountUseCase.invoke(email: emailController.text, password: passwordController.text);
        provider!.updateUser(response);
        navigator!.removeContext();
        navigator!.showSuccessMessage(message: "Logged in Successfully" , posActionTitle: "Ok" , posAction: goToHomeScreen);
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

  // login with google
  void loginWithGoogle()async{
    navigator!.showLoading("Logging In");
    try{
      var response = await signInWithGoogleUseCase.invoke();
      provider!.updateUser(response);
      navigator!.removeContext();
      navigator!.showSuccessMessage(message: "Logged in Successfully" , posActionTitle: "Ok" , posAction: goToHomeScreen);
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

  void goToHomeScreen(){
    navigator!.goToHomeScreen();
  }

  void goToRegisterScreen(){
    navigator!.goToRegisterScreen();
  }

  void goToResetScreen(){
    navigator!.goToResetScreen();
  }
}