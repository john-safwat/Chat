import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To Home Screen" , style: Theme.of(context).textTheme.displayMedium,),
      ),
    );
  }
}
