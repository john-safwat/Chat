import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Core/Dialogs/DialogUtils.dart';
import 'package:flutter/material.dart';

abstract class BaseState <T extends StatefulWidget , VM extends BaseViewModel>extends State<T> implements BaseNavigator{

  VM? viewModel ;

  @override
  void initState() {
    super.initState();
    viewModel = initialViewModel();
    viewModel!.navigator =this;
  }

  @override
  void dispose() {
    super.dispose();
    viewModel!.navigator = null;
    viewModel =null;
  }

  VM initialViewModel();


  @override
  hideLoading() {
    MyDialogUtils.hideDialog(context);
  }

  @override
  showFailMessage(String message) {
    MyDialogUtils.showFailMessage(context: context, message: message , posActionTitle: "Ok");
  }

  @override
  showLoading(String message) {
    MyDialogUtils.showLoadingDialog(context, message);
  }

  @override
  showSuccessMessage(String message , VoidCallback posActionCallBack) {
    MyDialogUtils.showSuccessMessage(context: context, message: message , posActionTitle: "Ok" , posAction: posActionCallBack);
  }

}
