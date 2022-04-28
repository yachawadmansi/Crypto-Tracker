import 'package:cryptotracker/Constants/Themes.dart';
import 'package:cryptotracker/Pages/Login%20page/Screens/Welcomepage/welcome_screen.dart';
import 'package:cryptotracker/Providers/Theme_provider.dart';
import 'package:cryptotracker/Providers/marketprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/localStorage.dart';
import 'Providers/Chart_provider.dart';

void main() async{
  // String currentTheme = await LocalStorage.getTheme()??"light";
  runApp(MyApp(
    // theme: currentTheme,
  ));

}

class MyApp extends StatelessWidget {
   // final String theme;
  // required this.theme;
   MyApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Marketprovider>(
          create: (context) => Marketprovider(),
        ),
        ChangeNotifierProvider<GraphProvider>(
          create: (context) => GraphProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider("light"),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode : themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darktheme,
            home: WelcomeScreen(),
          );
        },
      ),
    );
  }
}
