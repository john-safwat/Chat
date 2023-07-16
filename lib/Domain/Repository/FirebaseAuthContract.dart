import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Models/User/Users.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<String> createUser(UserDTO user);
  Future<String> loginUser(String email , String password);
}

abstract class FirebaseAuthRepository {
  Future<String> createUser(Users user);
  Future<String> loginUser(String email , String password);
}