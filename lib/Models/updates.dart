class Updates {
  String _subject;
  String _description;
  String _date;

  Updates(this._subject, this._description, this._date);

  Updates.map(dynamic obj) {
    this._subject = obj['subject'];
    this._description = obj['description'];
    this._date = obj['date'];
  }

  String get subject => _subject;
  String get description => _description;
  String get date => _date;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['subject'] = _subject;
    map['description'] = _description;
    map['date'] = _date;
    return map;
  }

  Updates.fromMap(Map<String, dynamic> map) {
    this._subject = map['subject'];
    this._description = map['description'];
    this._date = map['date'];
  }
}
