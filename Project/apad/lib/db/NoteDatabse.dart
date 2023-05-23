import 'dart:io';

import 'package:apad/model/SavedNotes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase{
  static final NoteDatabase noteDatabase=NoteDatabase._internal();
  String tableName="Notes";
  String colId="id";
  String colData="content";

  NoteDatabase._internal();

  factory NoteDatabase(){
    return noteDatabase;
  }

  static late Database _db;

  Future<Database> get db async{
    if(db==null){
      _db = await initDatabase();
    }
    return _db;
  }

  Future<Database> initDatabase()async{
    Directory dir =await getApplicationDocumentsDirectory();
    String path =dir.path+"SavedDatabase.db";

    var manager=await openDatabase(path,version: 1,onCreate: _onCreate);
    return manager;
  }

  void _onCreate(Database db,int version)async{
    await db.execute("create table $tableName($colId INTEGER PRIMARY KEY, $colData TEXT)");
  }

  Future<int> insertNote(SavedNotes savedNotes)async{
    Database db=await this.db;
    var result=await db.insert(tableName, savedNotes.tomap());
    return result;
  }

  Future<List<Map<String, Object>>> getNotes()async{
    Database db=await this.db;
    var result=await db.rawQuery("select * from $tableName order by $colId DESC");
    return result.map((map) => map.cast<String, Object>()).toList();
  }


}