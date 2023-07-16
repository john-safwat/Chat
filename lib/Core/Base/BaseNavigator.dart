import 'dart:ui';

abstract class BaseNavigator {
  showLoading(String message);
  showSuccessMessage(String message , VoidCallback posActionCallBack);
  showFailMessage(String message);
  hideLoading();
}