import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/mescours.dart';
import 'package:flutter/material.dart';

class HeuresRestants extends StatefulWidget {
  @override
  _HeuresRestantsState createState() => _HeuresRestantsState();
}

class _HeuresRestantsState extends State<HeuresRestants> {
  var db = new DBHelper();
  List<MesCours> dispensesData;
  String _intitule = "0";
  String _enseign = "0";
  String _volume = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: new Text(
          "Calcule heures restants",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: db.getHeureRestant(),
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
                      _volume = dispensesData[i].objectif;
                      _enseign =dispensesData[i].type;

                      int reste =  int.parse(_enseign) - int.parse(_volume);
                      

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
                                    
                                    Icon(Icons.star),
                                    Text(_enseign),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                              ),
                              Container(
                                
                                child: Row(
                                  
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  
                                  children: <Widget>[
                                    Icon(Icons.timer),
                                    Text(_volume),
                                  ],
                                ),
                              ),
                               Padding(
                                padding: EdgeInsets.all(15.0),
                              ),
                              Container(
                                
                                child: Row(
                                  
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  
                                  children: <Widget>[
                                    
                                    Icon(Icons.av_timer),
                                    Text(reste.toString()),
                                  ],
                                ),
                              )
                              
                              
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