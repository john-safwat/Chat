import 'package:chat/Data/Firebase/FirebaseAuth.dart';
import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource{

  FirebaseAuthConfig firebaseAuthConfig;
  FirebaseAuthRemoteDataSourceImpl(this.firebaseAuthConfig);

  @override
  Future<String> createUser(UserDTO user) async{
    try{
      var response = await firebaseAuthConfig.createAccount(user).timeout(const Duration(seconds: 15));
      return response;
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