import 'package:cryptotracker/Pages/Login%20page/Screens/Welcomepage/welcome_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: WelcomeScreen(),
    );

  }
}
  // const MyApp({Key? key}) : super(key: key);

