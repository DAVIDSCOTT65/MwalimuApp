import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/mescours.dart';
import 'package:ag_professeur/interfaces/mesdispenses.dart';
import 'package:flutter/material.dart';


class CoursPopulaire extends StatefulWidget {
  @override
  _CoursPopulaireState createState() => _CoursPopulaireState();
}

class _CoursPopulaireState extends State<CoursPopulaire> {

    var db = new DBHelper();
  List<MesDispenses> dispensesData;
  String _intitule = "0";
  String _etudiant = "0";
  String _volume = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Liste des cours populaires",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body:  FutureBuilder(
        future: db.getCoursPopulaire(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;
          dispensesData = data;

          return snapshot.hasData
              ? new Container(
                  child: ListView.builder(
                    itemCount: dispensesData == null ? 0 : dispensesData.length,
                    itemBuilder: (context, i) {
                      
                     
                      _intitule = dispensesData[i].cours;
                      _etudiant = dispensesData[i].etudiant;
                      

                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: new Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                padding: EdgeInsets.all(25.0),
                              ),
                              Container(
                                
                                child: Row(
                                  
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  
                                  children: <Widget>[
                                    
                                    Icon(Icons.people),
                                    Text(_etudiant),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(25.0),
                              ),
                              Container(
                                
                                child: Row(
                                  
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  
                                  children: <Widget>[
                                    
                                    Icon(Icons.star, color: Colors.red,),
                                    Text(_etudiant),
                                  ],
                                ),
                              ),
                              
                              
                            ],
                          ),
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