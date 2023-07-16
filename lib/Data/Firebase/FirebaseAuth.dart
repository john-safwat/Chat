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
       await firebase.createUserWithEmailAndPassword(
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

  Future<String>loginAccount(String email , String password)async{
    try{
      await firebase.signInWithEmailAndPassword(email: email, password: password);
      return firebase.currentUser!.uid;
    }on FirebaseAuthException catch(e){
      String error = '';
      switch (e.code) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
      error = "Wrong email/password combination.";
      break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
      error = "No user found with this email.";
      break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
      error =  "User disabled.";
      break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
      error =  "Too many requests to log into this account.";
      break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
      error =  "Email address is invalid.";
      break;
      default:
      error =  "Login failed. Please try again.";
      break;
      }
      throw MyFirebaseAuthException(error);
    }catch (e){
      throw MyFirebaseAuthException(e.toString());
    }
  }

}