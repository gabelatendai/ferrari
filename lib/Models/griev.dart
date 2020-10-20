class Griev{
  String _subject;
  String _description;
  String _category;

  Griev(this._subject,this._description,this._category);

  Griev.map(dynamic obj){
    this._subject = obj['subject'];
    this._description = obj['description'];
    this._category = obj['category'];

  }

  String get  subject=> _subject;
  String get description => _description;
  String get category => _category;


  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();
    map['subject']=_subject;
    map['description'] = _description;
    map['category'] = _category;
    return map;
  }

  Griev.fromMap(Map<String,dynamic> map){
    this._subject= map['subject'];
    this._description = map['description'];
    this._category = map['category'];

  }
}