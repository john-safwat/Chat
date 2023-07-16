import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthConfig {

  FirebaseAuthConfig._();
  static FirebaseAuthConfig? _instance;

  static FirebaseAuthConfig getFirebaseAuthConfig(){
    _instance ??= FirebaseAuthConfig._();
    return _instance!;
  }

  var firebase = FirebaseAuth.instance;

  Future<String> createAccount(UserDTO user)async{
    try{
      var response = await firebase.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password
      ).then((value) => value.user!.updateDisplayName(user.name)).timeout(const Duration(seconds: 15));
      return firebase.currentUser!.uid;
    }on FirebaseAuthException catch(e){
      var error;
      switch (e.code) {
        case "error_invalid_email":
          error = "Invalid Email Address";
          break;
        case "error_too_many_requests":
          error = "To Many Requests";
          break;
        case "error_operation_not_allowed":
          error = "Cannot Create Account Now Try Again Later";
          break;
        case "email-already-in-use":
          error = "Email Already In Use";
          break;
        default:
          error = e.toString();
      }
      throw MyFirebaseAuthException(error);
    }catch (e){
      throw MyFirebaseAuthException(e.toString());
    }
  }

}