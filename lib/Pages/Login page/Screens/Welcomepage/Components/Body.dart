import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cryptotracker/Pages/Login%20page/Screens/Login_page/login_screen.dart';
import 'package:cryptotracker/Pages/Login%20page/Screens/Signup_page/signup_screen.dart';
import 'package:cryptotracker/Pages/Login%20page/Screens/Welcomepage/Components/background.dart';
import 'package:cryptotracker/Pages/constants.dart';
import 'package:cryptotracker/Pages/Components/rounded_button.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Crypto-Tracker",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
                "assets/icons/home.svg",
              height: size.height*0.35,
            ),
            // Container(
            //
            //   child: Image.asset(
            //     "assets/images/welcomescreen.jpg",
            //     // fit: BoxFit.,
            //     cacheHeight: 350,
            //     cacheWidth: 350,
            //
            //
            //   ),
            // ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
