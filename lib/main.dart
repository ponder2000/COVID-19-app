import 'package:flutter/material.dart';
import 'package:coronaupdate/homepage.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Corona Updates",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
