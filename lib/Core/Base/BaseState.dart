import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Core/Dialogs/DialogUtils.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  VM? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initialViewModel();
    viewModel!.navigator = this;
  }

  @override
  void dispose() {
    super.dispose();
    viewModel!.navigator = null;
    viewModel = null;
  }

  VM initialViewModel();

  @override
  hideLoading() {
    MyDialogUtils.hideDialog(context);
  }

  @override
  showLoading(String message) {
    MyDialogUtils.showLoadingDialog(context, message);
  }

  @override
  showFailMessage(
      {required String message,
      String? posActionTitle,
      VoidCallback? posAction,
      String? negativeActionTitle,
      VoidCallback? negativeAction}) {
    MyDialogUtils.showFailMessage(
        context: context,
        message: message,
        negativeActionTitle: negativeActionTitle,
        posActionTitle: posActionTitle,
        posAction: posAction,
        negativeAction: negativeAction);
  }

  @override
  showSuccessMessage(
      {required String message,
      String? posActionTitle,
      VoidCallback? posAction,
      String? negativeActionTitle,
      VoidCallback? negativeAction}) {
    MyDialogUtils.showSuccessMessage(
        context: context,
        message: message,
        negativeActionTitle: negativeActionTitle,
        posActionTitle: posActionTitle,
        posAction: posAction,
        negativeAction: negativeAction);
  }

  @override
  showQuestionMessage(
      {required String message,
      String? posActionTitle,
      VoidCallback? posAction,
      String? negativeActionTitle,
      VoidCallback? negativeAction}) {
    MyDialogUtils.showQuestionMessage(
        context: context,
        message: message,
        negativeActionTitle: negativeActionTitle,
        posActionTitle: posActionTitle,
        posAction: posAction,
        negativeAction: negativeAction);
  }
}
