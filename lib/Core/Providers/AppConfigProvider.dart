import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {

  String? uid;

  void updateUid(String uid){
    this.uid = uid;
    notifyListeners();
  }

}
