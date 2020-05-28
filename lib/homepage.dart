import 'package:coronaupdate/summary_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url = 'https://api.covid19api.com/summary';
  var data;
  int totalDeath = 0;
  int totalRecover = 0;
  int totalCases = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body)['Countries'];
      if (data == null) {
        print("output from app => Unable to access the data");
      } else {
        print("output from app => Data access complete");
        for (int i = 0; i < data.length; i++) {
          data[i]['Country'] = data[i]['Country'].trim();
          totalCases += data[i]['TotalConfirmed'];
          totalRecover += data[i]['TotalRecovered'];
          totalDeath += data[i]['TotalDeaths'];
        }
      }
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('EEE, d MMM yyyy');
    return data == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.red,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/corona_image.png'),
                  )),
                  padding: EdgeInsets.only(left: 30.0),
                  alignment: Alignment.centerLeft,
                  height: 300.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${formatter.format(now)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        "Corona Virus Cases",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      Text(
                        "WorldWide",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/main_corona.png')),
                      color: Color(0xfff2f6f9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        customContainer(
                            title: "Active Cases",
                            number: totalCases,
                            color: Colors.black),
                        customContainer(
                            title: "Death Cases",
                            number: totalDeath,
                            color: Colors.red),
                        customContainer(
                            title: "Recovered Cases",
                            number: totalRecover,
                            color: Colors.green),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: Text("More info..."),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

Column customContainer({String title, int number, Color color}) {
  return Column(
    children: <Widget>[
      Container(
        height: 100.0,
        width: 300.0,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75))
          ],
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$title",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w300,
                fontSize: 30.0,
              ),
            ),
            Text(
              "${number.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: color,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 40.0,
      ),
    ],
  );
}
