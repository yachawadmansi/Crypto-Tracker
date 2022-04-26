import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;

  void toggletheme(){
    if(themeMode == ThemeMode.light){
      themeMode = ThemeMode.dark;
    }
    else{
      themeMode == ThemeMode.light;
    }
    notifyListeners();
  }
}