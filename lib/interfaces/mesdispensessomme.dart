class MesDispensesSomme {
  int id;
  String _cours;
  int _heure;
  int _minute;
  int _seconde;
  int _ouvrages;
  int  _visiteurs;
  int _etudiants;

  

  MesDispensesSomme(this._cours, this._heure, this._minute, this._seconde, this._ouvrages, this._visiteurs, this._etudiants);

  MesDispensesSomme.map(dynamic obj){
    this._cours = obj['Cours'];
    this._heure =obj['Heure'];
    this._minute =obj['Minute'];
    this._seconde =obj['Seconde'];
    this._ouvrages =obj['Ouvrages'];
    this._visiteurs =obj['Visiteurs'];
    this._etudiants =obj['Etudiants'];
  }

  String get cours => _cours;
  String get heure => _heure.toString();
  String get minute => _minute.toString();
  String get seconde => _seconde.toString();
  String get ouvrage => _ouvrages.toString();
  String get visiteur => _visiteurs.toString();
  String get etudiant => _etudiants.toString();

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['Cours'] = _cours;
    map['Heure'] = _heure;
    map['Minute'] = _minute;
    map['Seconde'] = _seconde;
    map['Ouvrages'] = _ouvrages;
    map['Visiteurs'] = _seconde;
    map['Etudiants'] =_etudiants;
    

    return map;
  }

  void setDispenseId(int id) {
    this.id = id;
  }

}