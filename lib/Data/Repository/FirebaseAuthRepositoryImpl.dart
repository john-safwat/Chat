
import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';

class FirebaseAuthRepositoryImpl implements  FirebaseAuthRepository{

  FirebaseAuthRemoteDataSource remoteDataSource;
  FirebaseAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> createUser(Users user) async{
    var response = await remoteDataSource.createUser(user.toDataSource());
    return response;
  }


}