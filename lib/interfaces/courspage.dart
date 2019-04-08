import 'package:ag_professeur/DB/DBHelper.dart';
import 'package:flutter/material.dart';
import 'package:ag_professeur/interfaces/mescours.dart';

class CoursPage extends StatefulWidget {
  CoursPage(this._mescours, this._isnew);

  final MesCours _mescours;
  final bool _isnew;

  @override
  _CoursPageState createState() => _CoursPageState();
}

class _CoursPageState extends State<CoursPage> {
  String title;
  bool btnSave;
  bool btnEdit;
  bool btnDelete;

  MesCours mycours;

  final cIntitule = TextEditingController();
  final cType = TextEditingController();
  final cObjectif = TextEditingController();

  bool _enableTextField = true;

  Future addRecord() async {
    var db = DBHelper();
    var mescours = MesCours(cIntitule.text, cType.text, cObjectif.text);
    await db.saveCours(mescours);
    print("Cours enregistrer");
  }

  Future updateRecord() async {}

  void _saveData() {
    if (widget._isnew) {
      addRecord();
    } else {
      updateRecord();
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    if (widget._mescours !=null) {
      mycours = widget._mescours;
      cIntitule.text=mycours.intitule;
      cType.text=mycours.type;
      cObjectif.text=mycours.objectif;
      title = "Mes cours";
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isnew) {
      title = "Nouveau Cours";
      btnSave = true;
      btnEdit = false;
      btnDelete = false;
    }else{
      btnSave = false;
      btnEdit = true;
      btnDelete = true;
      _enableTextField = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 25.0,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CreateButton(
                icon: Icons.save,
                enable: btnSave,
                onpress: _saveData,
              ),
              CreateButton(
                icon: Icons.edit,
                enable: btnEdit,
                onpress: () {},
              ),
              CreateButton(
                icon: Icons.delete,
                enable: btnDelete,
                onpress: () {},
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              enabled: _enableTextField,
              controller: cIntitule,
              decoration: InputDecoration(
                hintText: "Intitulé du cours",
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
              maxLines: null,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              enabled: _enableTextField,
              controller: cType,
              decoration: InputDecoration(
                hintText: "Type de cours",
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
              maxLines: null,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.newline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              enabled: _enableTextField,
              controller: cObjectif,
              decoration: InputDecoration(
                hintText: "Volume horaire",
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
              maxLines: null,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.newline,
            ),
          ),
        ],
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;

  CreateButton({this.icon, this.enable, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: enable ? Colors.purple : Colors.grey),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 18.0,
        onPressed: () {
          if (enable) {
            onpress();
          }
        },
      ),
    );
  }
}
