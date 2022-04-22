import 'dart:ui';
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Crypto-Tracker",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                "Today's Top Curriencies !!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 30,
              ),
              Markets(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
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
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites()),);
              },
              icon: Icon(Icons.wallet_membership),
            ),
            IconButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => Setting_page()),);
              },
              icon: Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => News_page()),);
              },
              icon: Icon(Icons.contact_page),
            ),
          ],
        ),
      ),
    );


  }
}
