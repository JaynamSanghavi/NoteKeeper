class Note{
  int _id;
  String _title;
  String _desc;
  String _date;
  int _priority;

  Note(this._title,this._date,this._priority,[this._desc]);
  Note.withId(this._id,this._title,this._date,this._priority,[this._desc]);

  int get id => _id;
  String get title => _title;
  String get desc => _desc;
  String get date => _date;
  int get priority => _priority;

  set title(String title){
    this._title = title;
  }

  set desc(String desc){
    this._desc = desc;
  }

  set date(String date){
    this._date = date;
  }

  set priority(int priority){
    this._priority = priority;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    if(id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['desc'] = _desc;
    map['date'] = _date;
    map['priority'] = _priority; 
    return map;
  }

  Note.fromMapObject(Map<String,dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._date = map['date'];
    this._priority = map['priority'];
    this._desc = map['desc'];
  }




}