import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Core/Providers/AppConfigProvider.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/UseCase/loginAccountUseCase.dart';
import 'package:chat/Presintation/Login/LoginNavigator.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator>{
  LoginAccountUseCase useCase;
  LoginViewModel(this.useCase);

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
  void login()async{
    if(formKey.currentState!.validate()){
      navigator!.showLoading("Logging In");
      try{
        var response = await useCase.invoke(email: emailController.text, password: passwordController.text);
        navigator!.hideLoading();
        navigator!.showSuccessMessage("Logged in Successfully", goToHomeScreen);
      }catch (e){
        navigator!.hideLoading();
        if(e is FirebaseAuthRemoteDataSourceException){
          navigator!.showFailMessage(e.errorMessage);
        }else if (e is FirebaseAuthTimeoutException){
          navigator!.showFailMessage(e.errorMessage);
        }else{
          navigator!.showFailMessage(e.toString());
        }
      }
    }
  }
  void goToHomeScreen(){
    navigator!.goToHomeScreen();
  }

  void goToRegisterScreen(){
    navigator!.goToRegisterScreen();
  }
}