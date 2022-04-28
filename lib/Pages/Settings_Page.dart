import 'package:cryptotracker/Providers/Theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text(
            "Settings",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "   Theme Settings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                IconButton(
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                  padding: EdgeInsets.all(30.0),
                  icon: (themeProvider.themeMode == ThemeMode.light)
                      ? Icon(Icons.dark_mode)
                      : Icon(Icons.light_mode),
                ),
              ])
            ],
          ),
        ));
  }
}
