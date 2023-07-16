import 'dart:async';
import 'dart:io';

import 'package:chat/Data/Firebase/FirebaseAuth.dart';
import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:chat/Domain/Exception/TimeoutException.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRemoteDataSourceImpl implements FirebaseAuthRemoteDataSource {
  FirebaseAuthConfig firebaseAuthConfig;
  FirebaseAuthRemoteDataSourceImpl(this.firebaseAuthConfig);

  @override
  Future<String> createUser(UserDTO user) async {
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
    } on TimeoutException catch (e) {
      throw FirebaseAuthTimeoutException("This Operation Timed out");
    } on IOException catch (e) {
      throw FirebaseAuthRemoteDataSourceException(
          "Check Your Internet Connection");
    } catch (e) {
      throw FirebaseAuthRemoteDataSourceException(e.toString());
    }
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      var response = await firebaseAuthConfig.loginAccount(email, password);
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
    } on TimeoutException catch (e) {
      throw FirebaseAuthTimeoutException("This Operation Timed out");
    } on IOException catch (e) {
      throw FirebaseAuthRemoteDataSourceException(
          "Check Your Internet Connection");
    } catch (e) {
      throw FirebaseAuthRemoteDataSourceException(e.toString());
    }
  }
}
