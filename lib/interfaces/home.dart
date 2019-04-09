


import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/courspage.dart';
import 'package:ag_professeur/interfaces/courspopulaire.dart';
import 'package:ag_professeur/interfaces/heurerestantant.dart';
import 'package:ag_professeur/interfaces/laffichagecours.dart';
import 'package:ag_professeur/interfaces/listcours.dart';
import 'package:ag_professeur/interfaces/rapportjour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = new DBHelper();
  @override
  //Construction de l'IU
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
          color: Colors.purple,
        ),
        backgroundColor: Colors.white,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => new CoursPage(null, true))),
      ),
      appBar: AppBar(
        //leading: Container(
        //padding: EdgeInsets.all(8.0),
        //child: Icon(Icons.bubble_chart, size: 40.0, color: Colors.purple,),
        // ),
        title: Text('Mwalimu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            )),
        backgroundColor: Colors.purple,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Miwalimu App"),
              accountEmail: new Text("www.mwalimuapp.com"),
              currentAccountPicture: new Image.asset("img/Splash.png"),
              decoration: new BoxDecoration(color: Colors.purple),
            ),
            new ListTile(
              title: new Text("Liste des cours "),
              trailing: new IconButton(
                icon: Icon(Icons.list),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AffichagesCours())),
              ),
            ),
            new ListTile(
              title: new Text("Rapports du jour "),
              trailing: new IconButton(
                icon: Icon(Icons.today),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => RapportJournalier())),
              ),
            ),
            new ListTile(
              title: new Text("Les cours populaires"),
              trailing: new IconButton(
                  icon: Icon(Icons.developer_board), onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => CoursPopulaire())),),
            ),
            new ListTile(
              title: new Text("Calcul heures restants"),
              trailing: new IconButton(
                icon: Icon(Icons.av_timer),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HeuresRestants())),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: db.getCours(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;

          return snapshot.hasData
              ? new CoursListe(data)
              : Center(
                  child: Text("Pas des données"),
                );
        },
      ),
    );
  }
}