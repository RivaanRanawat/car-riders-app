import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("test");
            databaseReference.set("isConnected");
          },
          height: 50,
          minWidth: 300,
          color: Colors.blue,
          child: Text("Chek"),
        ),
      ),
    );
  }
}