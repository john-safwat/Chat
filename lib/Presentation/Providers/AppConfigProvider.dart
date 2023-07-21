
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {

  User? user;
  AppConfigProvider({this.user});

  void updateUser(User user) {
    this.user= user;
    notifyListeners();
  }
  void removeUser(){
    user = null;
  }
}
