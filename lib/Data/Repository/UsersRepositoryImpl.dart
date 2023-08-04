import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/UsersRepositoryContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersRepositoryImpl implements UsersRepository{

  UsersFirebaseRemoteDataSource remoteDataSource;
  UsersRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> addUser(String roomId, Users user) async{
    var response = await remoteDataSource.addUser(roomId, user.toDataSource());
    return response;
  }

  @override
  Future<String> removeUser(String roomId, String userId) async{
    var response =  await remoteDataSource.removeUser(roomId, userId);
    return response;
  }

  @override
  Future<List<Users>> getUsersList(String roomId) async{
    var response = await remoteDataSource.getUsersList(roomId);
    return response;
  }

}