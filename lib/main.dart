import 'package:cryptotracker/Pages/Login%20page/Screens/Welcomepage/welcome_screen.dart';
import 'package:cryptotracker/Providers/marketprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Marketprovider>(
          create: (context) => Marketprovider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}

