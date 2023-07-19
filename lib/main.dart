import 'package:chat/Core/Providers/AppConfigProvider.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presintation/Create%20Room/CreateRoomView.dart';
import 'package:chat/Presintation/Home/HomeView.dart';
import 'package:chat/Presintation/Login/LoginView.dart';
import 'package:chat/Presintation/Register/RegisterView.dart';
import 'package:chat/Presintation/Search/SearchView.dart';
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
          CreateRoomView.routeName :(context) => CreateRoomView()
        },
        initialRoute: user == null?LoginScreen.routeName: HomeScreen.routeName,
        theme: MyTheme.light,
      ),
    );
  }
}
