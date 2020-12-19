import 'package:car_rider_app/screens/signup_screen.dart';
import 'package:car_rider_app/universal_variables.dart';
import 'package:car_rider_app/widgets/reusable_button.dart';
import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  static const String id = "login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
              child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 210,
                ),
                Text(
                  "Login As Rider",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: "Nunito-Bold"),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        style: TextStyle(fontSize: 14),
                        obscureText: true,
                      ),
                      SizedBox(height: 40),
                       ReusableButton(color: UniversalVariables.colorGreen, text: "LOGIN",onPressed: () {},),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, SignUpScreen.id, (route) => false),
                    child: Text("Don't have an account? Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
