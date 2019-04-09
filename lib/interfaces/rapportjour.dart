import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/mesdispenses.dart';
import 'package:flutter/material.dart';

class RapportJournalier extends StatefulWidget {
  @override
  _RapportJournalierState createState() => _RapportJournalierState();
}

class _RapportJournalierState extends State<RapportJournalier> {

  var db = new DBHelper();
   List<MesDispenses> dispensesData;
   String cours = "cours";
  String temps = "00:00:00";
  String nbrOuvrage = "0";
  String nbrVisiteur = "0";
  String nbrEtudiant = "0";
  var _date = DateTime.now();
  String now ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Rapports du jour",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),

      body:  FutureBuilder(
        future: db.getRapportJournalier("${_date.day}-${_date.month}-${_date.year}"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;
          dispensesData = data;

          return snapshot.hasData
              ? new Container(
                  child: ListView.builder(
                    itemCount: dispensesData == null ? 0 : dispensesData.length,
                    itemBuilder: (context, i) {
                      cours =dispensesData[i].cours;
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
                                  Text(cours),
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
      
    );
  }
}