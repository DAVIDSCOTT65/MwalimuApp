import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/listedispense.dart';
import 'package:ag_professeur/interfaces/mesdispenses.dart';
import 'package:ag_professeur/interfaces/mesdispensessomme.dart';
import 'package:flutter/material.dart';

class AffichagesDispenses extends StatefulWidget {
  AffichagesDispenses(this.cours);

  String cours = "";
  @override
  _AffichagesDispensesState createState() => _AffichagesDispensesState(cours);
}

class _AffichagesDispensesState extends State<AffichagesDispenses> {
  _AffichagesDispensesState(this.coursActuel);

  var db = new DBHelper();
  DBHelper ff;

  List<MesDispenses> dispensesData;
  List<MesDispensesSomme> dispensesSomme;

  MesDispenses sommation;

  String cours = "cours";
  String temps = "00:00:00";
  String nbrOuvrage = "0";
  String nbrVisiteur = "0";
  String nbrEtudiant = "0";
  String coursActuel = "";

  var data;
  AsyncSnapshot<dynamic> snapshot;

  int _heure = 0;
  int _minute = 0;
  int _seconde = 0;
  int _nbrEtudiant = 0;
  int _nbrVisiteur = 0;
  int _nbrOuvrage = 0;

  affichageCours(int etu, int ouvr, int visit) {
    //setState(() {

    _nbrOuvrage += ouvr;
    _nbrVisiteur += visit;
    _nbrEtudiant += etu;

    //});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Rapports ${coursActuel}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: db.getCourDispense(coursActuel),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          data = snapshot.data;
          dispensesData = data;

          return snapshot.hasData
              ? new Container(
                  child: ListView.builder(
                    itemCount: dispensesData == null ? 0 : dispensesData.length,
                    itemBuilder: (context, i) {
                      String _date = dispensesData[i].date;
                      temps = dispensesData[i].heure +
                          ":" +
                          dispensesData[i].minute +
                          ":" +
                          dispensesData[i].seconde;
                      nbrOuvrage = dispensesData[i].ouvrage;
                      nbrVisiteur = dispensesData[i].visiteur;
                      nbrEtudiant = dispensesData[i].etudiant;

                      return new Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.view_day),
                                  Text(_date),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.timer),
                                  Text(temps),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.book),
                                  Text(nbrOuvrage),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.person),
                                  Text(nbrVisiteur),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.people),
                                  Text(nbrEtudiant)
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Text("Pas des données"),
                );
        },
      ),
      bottomNavigationBar: FutureBuilder(
        future: db.getSommeCourDispense(coursActuel),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;
          dispensesSomme = data;
          int i = 0;

          var _date = DateTime.now();
          String now = "${_date.day}-${_date.month}-${_date.year}";
          _nbrOuvrage = int.parse(dispensesSomme[i].ouvrage);
          _nbrVisiteur = int.parse(dispensesSomme[i].visiteur);
          _nbrEtudiant = int.parse(dispensesSomme[i].etudiant);

          _heure = int.parse(dispensesSomme[i].heure);
          _minute = int.parse(dispensesSomme[i].minute);
          _seconde = int.parse(dispensesSomme[i].seconde);

          if (_seconde >= 60) {
            do {
              _minute++;
              _seconde -= 60;
              if (_minute >= 60) {
                do {
                  _heure++;
                  _minute -= 60;
                } while (_minute >= 60);
              }
            } while (_seconde >= 60);
          } else {}

          return snapshot.hasData
              ? new Material(
                  child: new Card(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.view_day,
                          color: Colors.purple,
                        ),
                        Text(now),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Icon(Icons.timer, color: Colors.purple),
                        Text(_heure.toString() +
                            ":" +
                            _minute.toString() +
                            ":" +
                            _seconde.toString()),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        Icon(Icons.book, color: Colors.purple),
                        Text(_nbrOuvrage.toString()),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Icon(Icons.person, color: Colors.purple),
                        Text(_nbrVisiteur.toString()),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                        ),
                        Icon(Icons.people, color: Colors.purple),
                        Text(_nbrEtudiant.toString())
                      ],
                    ),
                  ),

                  //),
                )
              : Center(
                  child: Text("Pas des données"),
                );
        },
      ),
    );
  }
}
