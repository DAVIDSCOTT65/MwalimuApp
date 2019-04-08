import 'dart:async';

import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/affichagecompteur.dart';
import 'package:ag_professeur/interfaces/mesdispenses.dart';
import 'package:ag_professeur/interfaces/ouvragesinterfaces.dart';
import 'package:flutter/material.dart';
import './listedispense.dart' as listecours;

class TimerInterface extends StatefulWidget {
  TimerInterface(this._intituleCours);

  String _intituleCours;
  //final _objectif;

  @override
  _TimerInterfaceState createState() => _TimerInterfaceState();
}

class _TimerInterfaceState extends State<TimerInterface>
    with SingleTickerProviderStateMixin {
  Stopwatch watch = new Stopwatch();
  Timer timer;
  String elapsedTime = "00:00:00";
  IconData icon = Icons.play_arrow;
  bool veri = false;
  int ouvrage = 0;
  int visiteur = 0;
  int etudiant = 0;
  TabController controller;
  String hoursStr = "0";
  String minutesStr = "0";
  String secondsStr = "0";
  var now =DateTime.now();

  Future addRecord() async {
    var db = DBHelper();
    String datenow = "${now.day}-${now.month}-${now.year}";
    var infoDispense = MesDispenses(
        widget._intituleCours,
        int.parse(hoursStr),
        int.parse(minutesStr),
        int.parse(secondsStr),
        ouvrage,
        visiteur,
        etudiant, 
        datenow);
    await db.saveInfoDispense(infoDispense);
    print("Info dispense enregistrer");
  }

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 4);
    super.initState();
  }

  void incrementeEtudiant() {
    setState(() {
      etudiant++;
    });
  }

  void decrementeEtudiant() {
    setState(() {
      etudiant--;
    });
  }

  void incrementOuvrage() {
    setState(() {
      ouvrage++;
    });
  }

  void incrementVisiteur() {
    setState(() {
      visiteur++;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget._intituleCours + " en mode dispense",
          style: TextStyle(color: Colors.white),
        ),
        /*
        leading: Container(
            child: new Column(
          children: <Widget>[
            SizedBox(width: 300.0),
            new FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: verification,
                child: new Icon(
                  icon,
                  color: Colors.purple,
                )),
          ],
        )),
        */
        backgroundColor: Colors.purple,
        // bottom: new TabBar(
        // controller: controller,
        // tabs: <Widget>[
        //   new Tab(icon: new Icon(Icons.stop_screen_share),),
        //  new Tab(icon: new Icon(Icons.stop_screen_share),),
        // new Tab(icon: new Icon(Icons.stop_screen_share),),
        //],
        // ),
      ),
       drawer: new Drawer(
        
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Liste des cours "),
              trailing: new Icon(Icons.list),
            ),
            new ListTile(
              title: new Text("Rapports du jour "),
              trailing: new Icon(Icons.today),
            ),
            new ListTile(
              title: new Text("A propos de nous"),
              trailing: new Icon(Icons.developer_board),
            ),
            new ListTile(
              title: new Text("Settings "),
              trailing: new Icon(Icons.settings),
            ),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close),
            ),
            
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.timer,
                  size: 50.0,
                  color: Colors.purple,
                ),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                new Text(
                  elapsedTime,
                  style: new TextStyle(fontSize: 25.0),
                  textAlign: TextAlign.right,
                ),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                new FloatingActionButton(
                backgroundColor: Colors.purple,
                onPressed: verification,
                child: new Icon(
                  icon,
                  color: Colors.white,
                )),
                SizedBox(height: 20.0)
              ],
            ),
          ),
          Divider(
            color: Colors.purple,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.book,
                      size: 50.0,
                      color: Colors.purple,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.topLeft,
                    ),
                    new Text(
                      "Ouvrages",
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                Column(
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.bottomCenter,
                    ),
                    new Text(
                      '${ouvrage}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                new Padding(
                  padding: EdgeInsets.all(28.0),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(width: 80.0),
                    FlatButton(
                      onPressed: incrementOuvrage,
                      color: Colors.white,
                      child: new Text(
                        "+",
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 28.0,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.purple,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.purple,
                ),
                new Text(
                  "Visiteurs",
                  style: new TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                SizedBox(height: 20.0),
                Text(
                  "${visiteur}",
                  style: TextStyle(fontSize: 20.0),
                ),
                new Padding(
                  padding: EdgeInsets.all(30.0),
                ),
                FlatButton(
                  onPressed: incrementVisiteur,
                  color: Colors.white,
                  child: new Text(
                    "+",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 28.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.purple,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.people,
                  size: 50.0,
                  color: Colors.purple,
                ),
                new Text(
                  "Etudiants",
                  style: new TextStyle(fontSize: 12.0),
                ),
                
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Text(
                  "${etudiant}",
                  style: TextStyle(fontSize: 20.0),
                ),
                FlatButton(
                  splashColor: Colors.red,
                  onPressed: decrementeEtudiant,
                  color: Colors.white,
                  child: new Text(
                    "-",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.purple,
                    ),
                  ),
                ),
                FlatButton(
                  splashColor: Colors.red,
                  onPressed: incrementeEtudiant,
                  color: Colors.white,
                  child: new Text(
                    "+",
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.purple,
          ),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.purple,
        child: new Row(
          children: <Widget>[
            new IconButton(
              
              icon: new Icon(Icons.list),
              onPressed: () {},
              
            ),
            Padding(
              padding: EdgeInsets.all(18.0),
            ),
            new IconButton(
              icon: new Icon(Icons.show_chart),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new AffichagesDispenses(widget._intituleCours ))),
            ),
            
          ],
        ),
      ),
    );
  }

  verification() {
    if (veri == true) {
      stopWatch();
      addRecord();
      icon = Icons.play_arrow;
    } else if (veri == false) {
      startWatch();
      icon = Icons.stop;
    }
  }

  updateTime(Timer timer) {
    setState(() {
      elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
    });
  }

  startWatch() {
    watch.start();
    timer = new Timer.periodic(new Duration(milliseconds: 1000), updateTime);

    veri = true;
  }

  stopWatch() {
    watch.stop();
    setTime();
    veri = false;
  }

  resetWatch() {
    watch.reset();
    setTime();
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    hoursStr = (hours % 60).toString().padLeft(2, '0');
    minutesStr = (minutes % 60).toString().padLeft(2, '0');
    secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    return "$hoursStr : $minutesStr : $secondsStr";
  }
}
