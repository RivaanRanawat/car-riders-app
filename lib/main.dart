import 'package:car_rider_app/screens/home_screen.dart';
import 'package:car_rider_app/screens/login_screen.dart';
import 'package:car_rider_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "dart:io";

import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialise database
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
            gcmSenderID: '297855924061',
            databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
          )
        : FirebaseOptions(
            googleAppID: '1:4489037899:android:78c852e8560367be92e5ce',
            apiKey: 'AIzaSyA3QHg_w4Kg8atFI6Z965PN7N5buFN3zzU',
            databaseURL: 'https://car-rider-app-default-rtdb.firebaseio.com',
          ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Nunito-Regular",
        primarySwatch: Colors.blue,
      ),
      initialRoute: SignUpScreen.id,
      routes: {
        SignUpScreen.id: (context) => SignUpScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen()
      },
    );
  }
}
