import 'package:ag_professeur/interfaces/mesdispenses.dart';
import 'package:flutter/material.dart';
import 'package:ag_professeur/DB/DBHelper.dart';

void main() {
  runApp(new MaterialApp(
    title: "Rapport",
    //home: new ListeDispense(dispensesData: new List<String>.generate(300, (i)=>"Ini data $i"),),
  ));
}

class ListeDispense extends StatelessWidget {
  final List<MesDispenses> dispensesData;
  ListeDispense(this.dispensesData, {Key key});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Container(
        child: new ListView.builder(
          itemCount: dispensesData == null ? 0 : dispensesData.length,
          itemBuilder: (context, i) {
            return new Card(
              child: new Text(dispensesData[i].cours),
            );
          },
        ),
      ),
    );
  }
}

