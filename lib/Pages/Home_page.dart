import 'dart:ui';
import 'package:cryptotracker/Pages/Settings_Page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Favourites.dart';
import 'Markets.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xFF0C1842),
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          "Crypto-Tracker",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
        ),
      ),
      // backgroundColor: Color.fromRGBO(7, 16, 51, 0.99),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Top Curriencies !!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  // color: Colors.white
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Markets(),
              Container(
                width: double.infinity,
                child: BottomAppBar(
                  elevation: 20.0,
                  // color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        icon: Icon(
                          Icons.home,
                          // color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Favourites()),
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.heart_fill,
                          // color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Setting_page()),);
                        },
                        icon: Icon(
                          CupertinoIcons.news_solid,
                          // color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Settings()),
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.settings_solid,
                          // color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
