class MesCours {
  int id;
  String _intitule;
  String _type;
  String _objectif;

  MesCours(this._intitule, this._type, this._objectif);

  MesCours.map(dynamic obj) {
    this._intitule = obj["intitule"];
    this._type = obj["type"];
    this._objectif = obj["objectif"];
  }

  String get intitule => _intitule;
  String get type => _type;
  String get objectif => _objectif;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['intitule'] = _intitule;
    map['type'] = _type;
    map['objectif'] = _objectif;

    return map;
  }

  void setCoursId(int id) {
    this.id = id;
  }
}
