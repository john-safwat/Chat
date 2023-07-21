import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<User> createUser(UserDTO user);
  Future<User> loginUser(String email , String password);
  Future<User> signInWithGoogle();
  Future<String> signOut();
  Future<String> resetPassword(String email);
}

abstract class FirebaseAuthRepository {
  Future<User> createUser(Users user);
  Future<User> loginUser(String email , String password);
  Future<User> signInWithGoogle();
  Future<String> signOut();
  Future<String> resetPassword(String email);
}


