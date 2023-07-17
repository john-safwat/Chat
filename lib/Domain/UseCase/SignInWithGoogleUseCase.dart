import 'package:chat/Domain/Repository/FirebaseAuthContract.dart';

class SignInWithGoogleUseCase {

  FirebaseAuthRepository repository ;
  SignInWithGoogleUseCase(this.repository);

  Future<String> invoke() async{
    var response = await repository.signInWithGoogle();
    return response;
  }

}