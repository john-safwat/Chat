import 'package:chat/Data/Models/User/UserDTO.dart';
import 'package:chat/Domain/Exception/FirebaseAuthException.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthConfig {

  // obtain the singleton pattern
  FirebaseAuthConfig._();
  static FirebaseAuthConfig? _instance;
  static FirebaseAuthConfig getFirebaseAuthConfig(){
    _instance ??= FirebaseAuthConfig._();
    return _instance!;
  }

  // get instance of firebase auth to use it in auth
  var firebase = FirebaseAuth.instance;

  // Create Account For User Using UserData
  Future<User> createAccount(UserDTO user)async{
    await firebase.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password
    ).then((value) => value.user!.updateDisplayName(user.name)).timeout(const Duration(seconds: 15));
    return firebase.currentUser!;
  }

  // login the user using the email and password
  Future<User>loginAccount(String email , String password)async{
    await firebase.signInWithEmailAndPassword(email: email, password: password);
    return firebase.currentUser!;
  }

  // login the user using google account
  Future<User> signInWithGoogle()async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn()
        .signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!
        .authentication;
    final user = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await firebase.signInWithCredential(user);
    return firebase.currentUser!;
  }

  // function to sign out the user
  Future<void> signOut()async{
    await firebase.signOut();
  }

  Future<void> deleteUser()async{
    await firebase.currentUser!.delete();
  }

  // function to send the reset password email
  Future<void> resetPasswordEmail(String email)async{
    await firebase.sendPasswordResetEmail(email: email);
  }
}