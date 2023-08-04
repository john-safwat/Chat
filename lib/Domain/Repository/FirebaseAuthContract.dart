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
abstract class FirebaseUsersRemoteDataSource{
  Future<void> addUser(UserDTO user);
  Future<bool> userExist(String uid);
}

abstract class FirebaseAuthRepository {
  Future<User> createUser(Users user);
  Future<User> loginUser(String email , String password);
  Future<User> signInWithGoogle();
  Future<String> signOut();
  Future<String> resetPassword(String email);
  Future<void> addUser(Users user);
  Future<bool> userExist(String uid);
}


