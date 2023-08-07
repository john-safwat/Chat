import 'package:chat/Core/Base/BaseNavigator.dart';
import 'package:chat/Core/Base/BaseViewModel.dart';
import 'package:chat/Core/Dialogs/DialogUtils.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presentation/Providers/AppConfigProvider.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  VM? viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initialViewModel();
    viewModel!.navigator = this;
    viewModel!.provider = Provider.of<AppConfigProvider>(context,listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    viewModel!.navigator = null;
    viewModel!.provider = null;
    viewModel = null;
  }

  VM initialViewModel();

  @override
  removeContext() {
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

  @override
  showNotification() {
    ElegantNotification(
      icon: const Icon(EvaIcons.copyOutline, color: MyTheme.white),
      width: MediaQuery.of(context).size.width,
      background: MyTheme.blue,
      animation: AnimationType.fromBottom,
      radius: 10,
      height: 60,
      closeButton: (dismissNotification) => InkWell(
        onTap: dismissNotification,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            EvaIcons.close,
            color: Colors.white,
          ),
        ),
      ),
      notificationPosition: NotificationPosition.bottomCenter,
      toastDuration: const Duration(seconds: 2),
      progressIndicatorColor: Colors.transparent,
      progressIndicatorBackground: Colors.transparent,
      animationDuration: const Duration(milliseconds: 500),
      description: const Text(
        "ID Coped Successfully",
        style: TextStyle(color: MyTheme.white),
      ),
    ).show(context);
  }
}
