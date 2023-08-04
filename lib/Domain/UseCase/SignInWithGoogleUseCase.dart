import 'package:chat/Domain/Models/User/Users.dart';
import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithGoogleUseCase {

  FirebaseAuthRepository repository ;
  SignInWithGoogleUseCase(this.repository);

  Future<User> invoke() async{
    var response = await repository.signInWithGoogle();
    var exist = await repository.userExist(response.uid);
    if(!exist){
      repository.addUser(Users(uid: response.uid, name: response.displayName!, email: response.email!, password: "google account"));
    }
    return response;
  }

}