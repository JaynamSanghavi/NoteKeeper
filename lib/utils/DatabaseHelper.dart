import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:notekeeper/models/note.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'desc';
  String colDate = 'date';
  String colPriority = 'priority';

  DatabaseHelper._createInstance();
  
  factory DatabaseHelper() {
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

   Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db"; 
    print(path+"-----------------");
    var notesDatabase = await openDatabase(path, version: 1, onCreate: createDatabase);
    return notesDatabase;
  }

  void createDatabase(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,'
    '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)'); 
  }

  // Insert Operation
  Future<int> insert(Note note) async {
    Database db = await this.database;
    int resultId = await db.insert(noteTable, note.toMap());
    return resultId;
  }

  // Update operation
  Future<int> update(Note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete operation
  Future<int> delete(int id) async {
    var db = await this.database;
    var result = db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects from the database.
  Future<int> getCount() async {
    var db = await this.database;
    List<Map<String, dynamic>> list = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(list);
    return result;
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    //var result = await db.rawQuery("SELECT * FROM $noteTable ORDER BY $colPriority ASC");
    var result = await db.query(noteTable, orderBy: '$colPriority ASC'); // helper function easier than rawQuery method
    return result;
  }

  Future<List<Note>> getNotesList() async {
    List<Map<String, dynamic>> notesMapList = await getNoteMapList(); // Get 'Map List' from database.
    int count = notesMapList.length; // Count the number of items in list.
    List<Note> notesList = List<Note>();
    
    // For loop to create a 'Note list' from a 'Map list'
    for(int i=0; i<count; i++) {
      notesList.add(Note.fromMapObject(notesMapList[i])); 
    }
    return notesList;
  }



}