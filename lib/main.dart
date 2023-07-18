import 'package:chat/Core/Providers/AppConfigProvider.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presintation/Home/HomeView.dart';
import 'package:chat/Presintation/Login/LoginView.dart';
import 'package:chat/Presintation/Register/RegisterView.dart';
import 'package:chat/Presintation/Search/SearchView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var response = prefs.getString("uid");

  runApp(MyApp(userId: response??"",));
}

class MyApp extends StatelessWidget {
  String userId;
  MyApp({super.key , required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => AppConfigProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterScreen.routeName :(context) => RegisterScreen(),
          HomeScreen.routeName:(context)=> HomeScreen(),
          LoginScreen.routeName : (context) => LoginScreen(),
          SearchView.routeName :(_) => SearchView(),
        },
        initialRoute: userId.isEmpty?LoginScreen.routeName: HomeScreen.routeName,
        theme: MyTheme.light,
      ),
    );
  }
}
