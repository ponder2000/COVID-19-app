import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coronaupdate/contries.dart';
import 'network.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;

  final List<Color> _colors = [
    Colors.blue,
    Colors.greenAccent,
    Colors.amber,
    Colors.deepOrange,
    Colors.pink,
  ];

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
        }
      }
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return data == null
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Container(
              color: Colors.brown,
              child: ListView.builder(
                padding: new EdgeInsets.all(10.0),
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) =>
                    details(index),
              ),
            ),
          );
  }

  Widget details(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CountryDetails(
                      country: data[index]['Country'],
                      newactive: getNewConfirms(data, index),
                      newdeath: getNewDeath(data, index),
                      newrecovered: getNewRecovers(data, index),
                      totalactive: getConfirms(data, index),
                      totaldeath: getDeaths(data, index),
                      totalrecovered: getRecovers(data, index),
                    )));
      },
      child: Card(
        elevation: 10.0,
        child: new Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/main_corona.png'))),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.all(10.0),
                child: new CircleAvatar(
                  radius: 27.0,
                  backgroundColor: _colors[index % _colors.length],
                  child: new Text(
                    data[index]['Country'][0],
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
//              new Padding(padding: EdgeInsets.only(top:10.0)),
              new Container(
                margin: const EdgeInsets.all(10.0),
                child: new Text(
                  data[index]['Country'].length < 10
                      ? data[index]['Country']
                      : data[index]['Country'].substring(0, 10),
                  style: TextStyle(
                      color: _colors[index % _colors.length],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
//                    new Padding(padding: EdgeInsets.only(top:12.0)),
              ),
              _subDetails(index),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subDetails(int index) {
    int death = getDeaths(data, index);
    int confirmed = getConfirms(data, index);
    int recovered = getRecovers(data, index);

    return Container(
      margin: const EdgeInsets.only(left: 50.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "Confirms $confirmed ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
//        new Padding(padding: EdgeInsets.only(top:10.0)),
          new Text(
            "Deaths $death ",
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
//        new Padding(padding: EdgeInsets.only(top:10.0)),
          new Text(
            "Recoveres $recovered",
            style: TextStyle(
                color: Colors.green,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
