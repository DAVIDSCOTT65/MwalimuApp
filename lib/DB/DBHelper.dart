import 'package:ag_professeur/interfaces/mescours.dart';
import 'package:ag_professeur/interfaces/mesdispenses.dart';
import 'package:ag_professeur/interfaces/mesdispensessomme.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';

class DBHelper {
  static final _instance = new DBHelper.internal();
  DBHelper.internal();

  

  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "AGProfDB");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Cours(id INTEGER PRIMARY KEY, intitule TEXT UNIQUE, type TEXT, objectif TEXT)");
    await db.execute(
        "CREATE TABLE Dispenser(id INTEGER PRIMARY KEY, Cours TEXT, Heure INTEGER, Minute INTEGER, Seconde INTEGER, Ouvrages INTEGER, Visiteurs INTEGER, Etudiants INTEGER, Date_Dispense TEXT)");
    print("La base de données a été crée");
  }

  Future<int> saveCours(MesCours cours) async {
    var dbClient = await db;
    int res = await dbClient.insert("Cours", cours.toMap());
    print("Cours inserer");
    return res;
  }

  Future<int> saveInfoDispense(MesDispenses dispenses) async {
    var dbClient = await db;
    int res = await dbClient.insert("Dispenser", dispenses.toMap());
    print("Info dispense inserer");
    return res;
  }

  Future<List<MesCours>> getCours() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM Cours");
    List<MesCours> coursData = new List();
    for (int i = 0; i < list.length; i++) {
      var cours = new MesCours(
          list[i]['intitule'], list[i]['type'], list[i]['objectif']);
      cours.setCoursId(list[i]['id']);
      coursData.add(cours);
    }

    return coursData;
  }
   Future<List<MesCours>> getHeureRestant() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT intitule, Objectif, CAST((Heure + Minute + Seconde) as TEXT)  as Heure FROM Cours INNER JOIN Dispenser ON Dispenser.Cours = Cours.Intitule GROUP BY intitule");
    List<MesCours> coursData = new List();
    for (int i = 0; i < list.length; i++) {
      var cours = new MesCours(
          list[i]['intitule'], list[i]['objectif'], list[i]['Heure']);
      cours.setCoursId(list[i]['id']);
      coursData.add(cours);
    }

    return coursData;
  }

  Future<List<MesDispenses>> getDispense() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM Dispenser");
    List<MesDispenses> dispensesData = new List();
    for (var i = 0; i < list.length; i++) {
      var dispense = new MesDispenses(
          list[i]['Cours'],
          list[i]['Heure'],
          list[i]['Minute'],
          list[i]['Seconde'],
          list[i]['Ouvrages'],
          list[i]['Visiteurs'],
          list[i]['Etudiants'],
          list[i]['Date_Dispense']);
      dispense.setDispenseId(list[i]['id']);
      dispensesData.add(dispense);
    }

    return dispensesData;
  }

  Future<List<MesDispenses>> getCourDispense(String cours) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("SELECT * FROM Dispenser WHERE Cours = ?", [cours]);
    List<MesDispenses> dispensesData = new List();
    for (var i = 0; i < list.length; i++) {
      var dispense = new MesDispenses(
          list[i]['Cours'],
          list[i]['Heure'],
          list[i]['Minute'],
          list[i]['Seconde'],
          list[i]['Ouvrages'],
          list[i]['Visiteurs'],
          list[i]['Etudiants'],
          list[i]['Date_Dispense']);
          
      dispense.setDispenseId(list[i]['id']);
      dispensesData.add(dispense);
    }

    return dispensesData;
  }
  Future<List<MesDispenses>> getRapportJournalier(String _date) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("SELECT * FROM Dispenser WHERE Date_Dispense = ?", [_date]);
    List<MesDispenses> dispensesData = new List();
    for (var i = 0; i < list.length; i++) {
      var dispense = new MesDispenses(
          list[i]['Cours'],
          list[i]['Heure'],
          list[i]['Minute'],
          list[i]['Seconde'],
          list[i]['Ouvrages'],
          list[i]['Visiteurs'],
          list[i]['Etudiants'],
          list[i]['Date_Dispense']);
          
      dispense.setDispenseId(list[i]['id']);
      dispensesData.add(dispense);
    }

    return dispensesData;
  }
  Future<List<MesDispensesSomme>> getSommeCourDispense(String cours) async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("SELECT id, Cours, SUM(Heure) AS Heures, SUM(Minute) AS Minutes, SUM(Seconde) AS Secondes, SUM(Ouvrages) AS Ouvrages, SUM(Visiteurs) AS Visiteurs, SUM(Etudiants) AS Etudiants FROM Dispenser WHERE Cours = ?", [cours]);
    List<MesDispensesSomme> dispensesData = new List();
    for (var i = 0; i < list.length; i++) {
      var dispense = new MesDispensesSomme(
          list[i]['Cours'],
          list[i]['Heures'],
          list[i]['Minutes'],
          list[i]['Secondes'],
          list[i]['Ouvrages'],
          list[i]['Visiteurs'],
          list[i]['Etudiants']);

         
          
      dispense.setDispenseId(list[i]['id']);
      dispensesData.add(dispense);
    }

    return dispensesData;
  }
  Future<List<MesDispenses>> getCoursPopulaire() async {
    var dbClient = await db;
    List<Map> list = await dbClient
        .rawQuery("SELECT Cours, SUM(Etudiants) AS Etudiants FROM Dispenser GROUP BY Cours ORDER BY Etudiants DESC");
    List<MesDispenses> dispensesData = new List();
    for (var i = 0; i < list.length; i++) {
      
      var dispense = new MesDispenses(
          
          list[i]['Cours'],
          list[i]['Heures'],
          list[i]['Minutes'],
          list[i]['Secondes'],
          list[i]['Ouvrages'],
          list[i]['Visiteurs'],
          list[i]['Etudiants'],
          list[i]['Date_Dispense']);
      
      dispense.setDispenseId(list[i]['id']);
      dispensesData.add(dispense);
    }

    return dispensesData;
  }

}
