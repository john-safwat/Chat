import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';

class ResetPasswordUseCase{
  FirebaseAuthRepository repository;
  ResetPasswordUseCase(this.repository);
  Future<String> invoke (String email)async{
    var response = await repository.resetPassword(email);
    return response;
  }
}