import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/courspage.dart';
import 'package:ag_professeur/interfaces/laffichagecours.dart';
import 'package:ag_professeur/interfaces/listcours.dart';
import 'package:ag_professeur/interfaces/rapportjour.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './interfaces/home.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AG Prof",
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home.dart' : (BuildContext context) => MyApp(),
      },
      home: SplashScreenOne(),
    );
  }
}



class SplashScreenOne extends StatefulWidget {
  @override
  _SplashScreenOneState createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {

  startTime() async{
    var _duration = const Duration(seconds: 10);
    return Timer(_duration, homepageroute);
  }

  void homepageroute(){
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) => new Home()
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 75.0,
                        child: Image.asset("img/dispense.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Mwalimu",
                        style: TextStyle(color: Colors.purpleAccent, fontSize: 24.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Text("Bienvenu chez Mwalimu", style: TextStyle(color: Colors.purpleAccent, fontSize: 18.0, fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
