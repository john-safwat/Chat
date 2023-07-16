import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';

class CreateAccountUseCase {

  FirebaseAuthRepository repository;
  CreateAccountUseCase(this.repository);

  Future<String> invoke({required String email ,required String name ,required String password})async{
    var response = await repository.createUser(Users(name: name, email: email, password: password));
    return response;
  }

}