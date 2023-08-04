import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Models/User/Users.dart';

abstract class UsersFirebaseRemoteDataSource {
  Future<String> addUser(String roomId , UserDTO user);
  Future<String> removeUser(String roomId , String userId);
}

abstract class UsersRepository{
  Future<String> addUser(String roomId , Users user);
  Future<String> removeUser(String roomId , String userId);
}