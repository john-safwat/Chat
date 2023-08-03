import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepositoryImpl implements  FirebaseAuthRepository{
  FirebaseAuthRemoteDataSource remoteDataSource;
  FirebaseUsersRemoteDataSource usersRemoteDataSource;
  FirebaseAuthRepositoryImpl(this.remoteDataSource ,this.usersRemoteDataSource);

  @override
  Future<User> createUser(Users user) async{
    var response = await remoteDataSource.createUser(user.toDataSource());
    return response;
  }

  @override
  Future<User> loginUser(String email, String password) async{
    var response = await remoteDataSource.loginUser(email, password);
    return response;
  }

  @override
  Future<User> signInWithGoogle() async{
    var response = await remoteDataSource.signInWithGoogle();
    return response;
  }

  @override
  Future<String> signOut() async{
    var response =  await remoteDataSource.signOut();
    return response;
  }

  @override
  Future<String> resetPassword(String email) async{
    var response = await remoteDataSource.resetPassword(email);
    return response;
  }

  @override
  Future<void> addUser(UserDTO user) async{
    await usersRemoteDataSource.addUser(user);
  }
}