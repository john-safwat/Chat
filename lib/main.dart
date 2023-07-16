import 'package:chat/Core/Providers/AppConfigProvider.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Presintation/Home/HomeView.dart';
import 'package:chat/Presintation/Register/RegisterView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          HomeScreen.routeName:(context)=>HomeScreen()
        },
        initialRoute: RegisterScreen.routeName,
        theme: MyTheme.light,
      ),
    );
  }
}
