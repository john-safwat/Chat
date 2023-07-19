import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithGoogleUseCase {

  FirebaseAuthRepository repository ;
  SignInWithGoogleUseCase(this.repository);

  Future<User> invoke() async{
    var response = await repository.signInWithGoogle();
    return response;
  }

}