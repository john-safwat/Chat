import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Models/User/Users.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<String> createUser(UserDTO user);
}

abstract class FirebaseAuthRepository {
  Future<String> createUser(Users user);
}