import 'package:chat/Presentation/Providers/AppConfigProvider.dart';
import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:chat/Presentation/UI/Create%20Room/CreateRoomView.dart';
import 'package:chat/Presentation/UI/Home/HomeView.dart';
import 'package:chat/Presentation/UI/Login/LoginView.dart';
import 'package:chat/Presentation/UI/ResetPassword/ResetPasswordView.dart';
import 'package:chat/Presentation/UI/Register/RegisterView.dart';
import 'package:chat/Presentation/UI/Search/SearchView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(user: user,));
}

class MyApp extends StatelessWidget {
  User? user;
  MyApp({super.key , required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => AppConfigProvider(user: user)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterScreen.routeName :(context) => RegisterScreen(),
          HomeScreen.routeName:(context)=> HomeScreen(),
          LoginScreen.routeName : (context) => LoginScreen(),
          SearchView.routeName :(context) => SearchView(),
          CreateRoomView.routeName :(context) => CreateRoomView(),
          ResetPasswordScreen.routeName : (context) => ResetPasswordScreen()
        },
        initialRoute: user == null?LoginScreen.routeName: HomeScreen.routeName,
        theme: MyTheme.light,
      ),
    );
  }
}
