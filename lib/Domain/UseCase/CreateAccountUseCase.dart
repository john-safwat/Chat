import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountUseCase {

  FirebaseAuthRepository repository;
  CreateAccountUseCase(this.repository);

  Future<User> invoke({required String email ,required String name ,required String password})async{
    var response = await repository.createUser(Users( uid: '', name: name, email: email, password: password));
    await repository.addUser(Users(uid: response.uid, name: name, email: email, password: password));
    return response;
  }
}