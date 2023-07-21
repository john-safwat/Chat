import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginAccountUseCase{
  FirebaseAuthRepository repository;
  LoginAccountUseCase(this.repository);
  Future<User> invoke({required String email, required String password})async{
    var response = await repository.loginUser(email, password);
    return response;
  }
}