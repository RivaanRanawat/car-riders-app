import 'package:car_rider_app/dataprovider/appData.dart';
import 'package:car_rider_app/screens/home_screen.dart';
import 'package:car_rider_app/screens/login_screen.dart';
import 'package:car_rider_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "dart:io";

import 'package:provider/provider.dart';

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
            googleAppID: '1:74445978662:android:58946ceeb822317b163ae7',
            apiKey: 'AIzaSyDlN5S_ny58G9dUgtHIcJPt2HdFopOoDyQ',
            databaseURL: 'https://cab-rider-app-default-rtdb.firebaseio.com',
          ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Nunito-Regular",
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          SignUpScreen.id: (context) => SignUpScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen()
        },
      ),
    );
  }
}
