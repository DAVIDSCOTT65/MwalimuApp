import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:ag_professeur/interfaces/courspage.dart';
import 'package:ag_professeur/interfaces/listcours.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AG Prof",
      debugShowCheckedModeBanner: false,
      home: new Home(),
    );
  }
}

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
              accountName: new Text("Mirindi David"),
              accountEmail: new Text("davidscottmirindi65@gmail.com"),
              currentAccountPicture: new Image.asset("name"),
            ),
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

class Cours extends StatelessWidget {
  TextEditingController controllerCours = new TextEditingController();
  TextEditingController controllerType = new TextEditingController();
  TextEditingController controllerDescription = new TextEditingController();
  TextEditingController controllerObjectif = new TextEditingController();

  void recupererDonnee() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 200.0,
        child: new Column(
          children: <Widget>[
            new Text("              Cours : ${controllerCours.text}"),
            new Text("               Type : ${controllerType.text}"),
            new Text("        Description : ${controllerDescription.text}"),
            new Text("Objectif journalier : ${controllerObjectif.text}"),
          ],
        ),
      ),
    );
    //showDialog( child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF18D191),
        title: new Text("Ajouter un Cours"),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(20.0),
            ),
            new TextField(
              controller: controllerCours,
              decoration: new InputDecoration(
                  hintText: "Entrée le nom du cours",
                  labelText: "Cours",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0))),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            new TextField(
              controller: controllerType,
              decoration: new InputDecoration(
                  hintText: "Entrée le type de cours",
                  labelText: "Type",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0))),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            new TextField(
              controller: controllerDescription,
              decoration: new InputDecoration(
                  hintText: "Entrée la description du cours",
                  labelText: "Description",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0))),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            new TextField(
              controller: controllerObjectif,
              decoration: new InputDecoration(
                  hintText: "Entrée le nombre d'heure à réaliser par jour",
                  labelText: "Objectif Journalier",
                  border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0))),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 20.0),
            ),
            new RaisedButton(
              child: new Text(
                "Enregistré",
                style: new TextStyle(color: Colors.white),
              ),
              color: Color(0xFF18D191),
              onPressed: () {
                recupererDonnee();
              },
            ),
          ],
        ),
      ),
    );
  }
}
