import 'dart:ui';

abstract class BaseNavigator {
  showLoading(String message);
  showSuccessMessage({
    required String message,
    String? posActionTitle,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  });
  showFailMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  });
  showQuestionMessage({
    required String message ,
    String? posActionTitle ,
    VoidCallback? posAction,
    String? negativeActionTitle,
    VoidCallback? negativeAction,
  });
  hideLoading();
}