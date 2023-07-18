import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String? uid;

  void updateUid(String uid) {
    this.uid = uid;
    notifyListeners();
  }

  Future<void> updateUidInSharedPref(String uid) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", uid);
  }
}
