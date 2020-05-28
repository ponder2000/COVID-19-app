import 'package:coronaupdate/homepage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryDetails extends StatelessWidget {
  final String country;
  final int totalactive;
  final int totaldeath;
  final int totalrecovered;
  final int newactive;
  final int newdeath;
  final int newrecovered;

  CountryDetails({
    this.country,
    this.newactive,
    this.newdeath,
    this.newrecovered,
    this.totalactive,
    this.totaldeath,
    this.totalrecovered,
  });

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('EEE, d MMM yyyy');

    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/sub_corona.png'))),
              alignment: Alignment.center,
              height: 150.0,
              child: Text(
                "Data of $country \nbefore ${formatter.format(now)}",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/main_corona.png')),
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  customContainer(
                    title: "Total ActiveCases",
                    number: totalactive,
                  ),
                  customContainer(
                    title: "Total DeathCases",
                    number: totaldeath,
                    color: Colors.red,
                  ),
                  customContainer(
                    title: "Total RecoveredCases",
                    number: totalrecovered,
                    color: Colors.green,
                  ),
                  customContainer(title: "New ActiveCases", number: newactive),
                  customContainer(
                    title: "New DeathCases",
                    number: newdeath,
                    color: Colors.redAccent,
                  ),
                  customContainer(
                    title: "New RecoveredCases",
                    number: newrecovered,
                    color: Colors.greenAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
