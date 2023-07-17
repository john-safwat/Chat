import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthConfig {

  FirebaseAuthConfig._();
  static FirebaseAuthConfig? _instance;

  static FirebaseAuthConfig getFirebaseAuthConfig(){
    _instance ??= FirebaseAuthConfig._();
    return _instance!;
  }

  var firebase = FirebaseAuth.instance;

  Future<String> createAccount(UserDTO user)async{
    await firebase.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password
    ).then((value) => value.user!.updateDisplayName(user.name)).timeout(const Duration(seconds: 15));
    return firebase.currentUser!.uid;
  }

  Future<String>loginAccount(String email , String password)async{
    await firebase.signInWithEmailAndPassword(email: email, password: password);
    return firebase.currentUser!.uid;
  }

  Future<String> signInWithGoogle()async{

    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    final user = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    
    firebase.signInWithCredential(user);

    return firebase.currentUser?.uid??"";
  }


}