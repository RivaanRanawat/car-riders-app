import 'package:car_rider_app/universal_variables.dart';
import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
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
                  "Sign In As Rider",
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
                        keyboardType: TextInputType.emailAddress,
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
                              "LOGIN",
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
                    onPressed: () {},
                    child: Text("Don't have an account? Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
