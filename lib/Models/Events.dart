class Events {
  String _subject;
  String _description;
  // DateTime _date;

  Events(this._subject, this._description);

  Events.map(dynamic obj) {
    this._subject = obj['subject'];
    this._description = obj['description'];
    // this._date = obj['date'];
  }

  String get subject => _subject;
  String get description => _description;
  // DateTime get date => _date;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['subject'] = _subject;
    map['description'] = _description;
    // map['date'] = _date;
    return map;
  }

  Events.fromMap(Map<String, dynamic> map) {
    this._subject = map['subject'];
    this._description = map['description'];
    // this._date = map['date'];
  }
}
