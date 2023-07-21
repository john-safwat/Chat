import 'dart:async';
import 'dart:io';

import 'package:chat/Data/Firebase/FirebaseAuth.dart';
import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/FirebaseAuthTimeoutException.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  FirebaseAuthConfig firebaseAuthConfig;
  FirebaseAuthRemoteDataSourceImpl(this.firebaseAuthConfig);

  @override
  Future<User> createUser(UserDTO user) async {
    try {
      var response = await firebaseAuthConfig
          .createAccount(user)
          .timeout(const Duration(seconds: 15));
      return response;
    } on FirebaseAuthException catch (e) {
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
      throw FirebaseAuthRemoteDataSourceException(error);
    }on TimeoutException catch(e){
      throw FirebaseAuthTimeoutException("This Operation has Timed out");
    } on IOException catch (e){
      throw FirebaseAuthRemoteDataSourceException("Check Your Internet Connection");
    }catch (e) {
      throw FirebaseAuthRemoteDataSourceException(e.toString());
    }
  }

  @override
  Future<User> loginUser(String email, String password) async {
    try {
      var response = await firebaseAuthConfig.loginAccount(email, password).timeout(const Duration(seconds: 15));
      return response;
    } on FirebaseAuthException catch (e) {
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
          error = "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          break;
        default:
          error = "Login failed. Please try again.";
          break;
      }
      throw FirebaseAuthRemoteDataSourceException(error);
    }on TimeoutException catch(e){
      throw FirebaseAuthTimeoutException("This Operation has Timed out");
    } on IOException catch (e){
      throw FirebaseAuthRemoteDataSourceException("Check Your Internet Connection");
    }catch (e) {
      throw FirebaseAuthRemoteDataSourceException(e.toString());
    }
  }

  @override
  Future<User> signInWithGoogle() async{
    try {
      var response = await firebaseAuthConfig.signInWithGoogle();
      return response;
    } on FirebaseAuthException catch (e) {
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
          error = "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          break;
        default:
          error = "Login failed. Please try again.";
          break;
      }
      throw FirebaseAuthRemoteDataSourceException(error);
    }on TimeoutException catch(e){
      throw FirebaseAuthTimeoutException("This Operation has Timed out");
    } on IOException catch (e){
      throw FirebaseAuthRemoteDataSourceException("Check Your Internet Connection");
    }catch (e) {
      throw FirebaseAuthRemoteDataSourceException(e.toString());
    }
  }

  @override
  Future<String> signOut() async{
    try{
      await firebaseAuthConfig.signOut();
      return "Signed Out Successfully";
    }on FirebaseAuthException catch (e) {
      String error = '';
      switch (e.code) {
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error = "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error = "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          error = "Operation Not Allowed";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error = "Email address is invalid.";
          break;
        default:
          error = "Login failed. Please try again.";
          break;
      }
      throw FirebaseAuthRemoteDataSourceException(error);
    }on TimeoutException catch(e){
      throw FirebaseAuthTimeoutException("This Operation has Timed out");
    } on IOException catch (e){
      throw FirebaseAuthRemoteDataSourceException("Check Your Internet Connection");
    }catch (e) {
      throw FirebaseAuthRemoteDataSourceException(e.toString());
    }
  }

  @override
  Future<String> resetPassword(String email)async{
    try{
      var response = await firebaseAuthConfig.resetPasswordEmail(email);
      return "Email Sent to $email";
    }on FirebaseAuthException catch (e) {
      throw FirebaseAuthRemoteDataSourceException("Please try again later");
    }on TimeoutException catch(e){
      throw FirebaseAuthTimeoutException("This Operation has Timed out");
    } on IOException catch (e){
      throw FirebaseAuthRemoteDataSourceException("Check Your Internet Connection");
    }catch (e) {
      throw FirebaseAuthRemoteDataSourceException(e.toString());
    }
  }


}

