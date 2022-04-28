import 'package:cryptotracker/Pages/Login%20page/Screens/Welcomepage/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cryptotracker/Pages/Login page/Screens/Login_page/login_screen.dart';
import 'package:cryptotracker/Pages/Login page/Screens/Signup_page/Components/background.dart';
import 'package:cryptotracker/Pages/Login page/Screens/Signup_page/Components/or_divider.dart';
import 'package:cryptotracker/Pages/Login page/Screens/Signup_page/Components/social_icon.dart';
import 'package:cryptotracker/Pages/Components/already_have_an_account_acheck.dart';
import 'package:cryptotracker/Pages/Components/rounded_button.dart';
import 'package:cryptotracker/Pages/Components/rounded_input_feild.dart';
import 'package:cryptotracker/Pages/Components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // final _auth = FirebaseAuth.instance;
  String email = '0ppppppp';
  String password = 'ox0x0x0x';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "SIGNUP",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/loginmain.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                setState(() {
                  showSpinner = true;
                });
                //   try {
                //     // final newUser = await _auth.createUserWithEmailAndPassword(
                //     //     email: email, password: password);
                //     if (newUser != null) {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) {
                //             return WelcomeScreen();
                //           },
                //         ),
                //       );
                //       ;
                //     }
                //
                //     setState(() {
                //       showSpinner = false;
                //     });
                //   } catch (e) {
                //     print(e);
                //   }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
