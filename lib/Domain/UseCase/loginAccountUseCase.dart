import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';

class LoginAccountUseCase{
  FirebaseAuthRepository repository;
  LoginAccountUseCase(this.repository);
  Future<String> invoke({required String email, required String password})async{
    var response = await repository.loginUser(email, password);
    return response;
  }
}