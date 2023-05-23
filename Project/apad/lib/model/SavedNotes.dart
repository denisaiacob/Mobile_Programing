class SavedNotes{
  late int _id;
  late String _content;

  SavedNotes(this._content);

  SavedNotes.WithId(this._id,this._content);

  Map<String,dynamic>tomap(){
    var map = <String, dynamic>{
      'content': _content,
    };

    if(_id!=null){
      map['id']=_id;
    }
    return map;
  }

  SavedNotes.FromObject(dynamic o){
    _id=o["id"];
    _content=o["content"];
  }

  String get content => _content;
  set content(String value){
    _content=value;
  }

  int get id => _id;
  set id(int value) {
    _id = value;
  }
}