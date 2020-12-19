import 'package:car_rider_app/screens/login_screen.dart';
import 'package:car_rider_app/universal_variables.dart';
import "package:flutter/material.dart";

class SignUpScreen extends StatelessWidget {

  static const String id = "signup";

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
                  "Create Rider's Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: "Nunito-Bold"),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Full Name",
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
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone",
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
                      RaisedButton(
                        onPressed: () {},
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25),
                        ),
                        color: UniversalVariables.colorGreen,
                        textColor: Colors.white,
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Nunito-Bold",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false),
                    child: Text("Already have an account? Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
