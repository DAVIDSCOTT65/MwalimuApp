import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/mescours.dart';
import 'package:flutter/material.dart';

class AffichagesCours extends StatefulWidget {
  @override
  _AffichagesCoursState createState() => _AffichagesCoursState();
}

class _AffichagesCoursState extends State<AffichagesCours> {
  var db = new DBHelper();
  List<MesCours> dispensesData;
  String _intitule = "0";
  String _type = "0";
  String _volume = "0";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Liste des cours",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),

      body: FutureBuilder(
        future: db.getCours(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;
          dispensesData = data;

          return snapshot.hasData
              ? new Container(
                  child: ListView.builder(
                    itemCount: dispensesData == null ? 0 : dispensesData.length,
                    itemBuilder: (context, i) {
                      
                     
                      _intitule = dispensesData[i].intitule;
                      _type = dispensesData[i].type;
                      _volume = dispensesData[i].objectif;

                      return new Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.view_day),
                                  Text(_intitule),
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
                                  Text(_type),
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
                                  Text(_volume),
                                ],
                              ),
                            ),
                            
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