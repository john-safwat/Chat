import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/UseCase/ResetPasswordUseCase.dart';
import 'package:chat/Presentation/UI/ResetPassword/ResetPasswordNavigator.dart';
import 'package:flutter/material.dart';

class ResetPasswordViewModel extends BaseViewModel<ResetPasswordNavigator>{
  TextEditingController emailResetController = TextEditingController();
  ResetPasswordUseCase useCase;
  ResetPasswordViewModel(this.useCase);
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

  void resetPassword()async{
    navigator!.showLoading("Sending Email");
      try{
        var response = await useCase.invoke(emailResetController.text);
        navigator!.removeContext();
        navigator!.showSuccessMessage(message: "Email Sent Successfully", posActionTitle: "ok");
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