import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Core/Providers/AppConfigProvider.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/TimeoutException.dart';
import 'package:chat/Domain/UseCase/CreateAccountUseCase.dart';
import 'package:chat/Presintation/Register/RegisterNavigator.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel<RegisterNavigator>{

  CreateAccountUseCase useCase;
  RegisterViewModel(this.useCase);

  final fromKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  AppConfigProvider? provider ;

  // validate on the name if it is not empty and doesn't contain ant spacial characters
  String? nameValidation(String name){
    if (name.isEmpty){
      return "Name Can't be Empty";
    }else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]').hasMatch(name)){
      return "Invalid Name";
    }else {
      return null;
    }
  }
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


  void register()async{
    if(fromKey.currentState!.validate()){
      navigator!.showLoading("Creating Your Account");
      if(passwordController.text == passwordConfirmationController.text){
        try{
          var response = await useCase.invoke(email: emailController.text, name: nameController.text, password: passwordController.text);
          navigator!.hideLoading();
          navigator!.showSuccessMessage("Account Created Successfully" , goToHomeScreen);
        }catch (e){
          navigator!.hideLoading();
          if(e is FirebaseAuthRemoteDataSourceException){
            navigator!.showFailMessage(e.errorMessage);
          }else if (e is FirebaseAuthTimeoutException){
            navigator!.showFailMessage(e.errorMessage);
          }else {
            navigator!.showFailMessage(e.toString());
          }
        }
      }else {
        navigator!.showFailMessage("Passwords Doesn't Match");
      }
    }
  }

  void goToHomeScreen(){
    navigator!.goToHomeScreen();
  }

  void goToLoginScreen(){
    navigator!.goToLoginScreen();
  }
}