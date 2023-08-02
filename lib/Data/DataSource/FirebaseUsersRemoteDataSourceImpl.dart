import 'package:chat/Data/Firebase/UsersDataBase.dart';
import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';

class FirebaseUsersRemoteDataSourceImpl implements FirebaseUsersRemoteDataSource{
  UsersDataBase usersDataBase;
  FirebaseUsersRemoteDataSourceImpl(this.usersDataBase);
  @override
  Future<void> addUser(UserDTO user) async{
    await usersDataBase.addUser(user);
  }

}