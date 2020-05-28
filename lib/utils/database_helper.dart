//in this vedio I'll try to build the main function with the GUI
// lets Start
import 'dart:io';
import 'dart:async';
import 'package:covid19information/models/student_to_use_with_sqlliet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database _myDB;

  //The table & columns names
  String _studentTable = 'studentTable';
  String _studentIdColumn = 'studentIdColumn';
  String _studentNameColumn = 'studentNameColumn';
  String _studentAgeColumn = 'studentAgeColumn';
  String _studentClassColumn = 'studentClassColumn';
  String _studentEmailColumn = 'studentEmailColumn';
  String _studentAddressColumn = 'studentAddressColumn';

  //get reference to the database
  Future<Database> get myDb async {
    if (_myDB != null) {
      return _myDB;
    } else {
      _myDB = await initMyDB();

      return _myDB;
    }
  }

  //initialize the database and connect the path with the database
  initMyDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'myDatabase.db');
    var myownDB = await openDatabase(path, version: 1, onCreate: _CreateDB);
    return myownDB;
  }

  //create the table and columns in the database
  void _CreateDB(Database db, int newVersion) async {
    String sql =
        "CREATE TABLE $_studentTable($_studentIdColumn INTEGER PRIMARY KEY,$_studentNameColumn TEXT,"
        "$_studentAgeColumn TEXT,$_studentClassColumn TEXT,$_studentEmailColumn TEXT,$_studentAddressColumn TEXT )";
    await db.execute(sql);
  }

// insert student to the database
  Future<int> insertStudent(
      StudentToUseWithSQLite studentToUseWithSQLite) async {
    var db = await myDb;
    int result = await db.insert(
      "$_studentTable",
      studentToUseWithSQLite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

//delete student from database
  Future<int> deleteStudent(int id) async {
    var db = await myDb;
    //or you can do like this
    return await db.delete(
      "$_studentTable",
      where: '$_studentIdColumn=?',
      whereArgs: [id],
    );
//    var result = await db.delete(
//      "$_studentTable",
//      where: '$_studentIdColumn=?',
//      whereArgs: [id],
//    );
//
//    return result;
  }

//update student information
  Future<int> updateStudent(
      StudentToUseWithSQLite studentToUseWithSQLite) async {
    var db = await myDb;
    return await db.update(
      "$_studentTable",
      studentToUseWithSQLite.toMap(),
      where: '$_studentIdColumn=?',
      whereArgs: [studentToUseWithSQLite.studentId],
    );
  }

  //get student inforamtion from the database by id
  Future<StudentToUseWithSQLite> getStudent(int id) async {
    var db = await myDb;
    String sql = "SELECT * FROM $_studentTable WHERE $_studentIdColumn=$id";
    var result = await db.rawQuery(sql);
    if (result.length == 0) return null;
    return StudentToUseWithSQLite.fromMap(result.first);
  }

  //get student information from the database by name
  Future<StudentToUseWithSQLite> getStudentByName(String studentName) async {
    var db = await myDb;
    String sql =
        "SELECT * FROM $_studentTable WHERE $_studentNameColumn=$studentName";
    var result = await db.rawQuery(sql);
    if (result.length == 0) return null;
    return StudentToUseWithSQLite.fromMap(result.first);
  }

  //get the number of student in the database
  Future<int> getStudentCount() async {
    var db = await myDb;
    var sql = "SELECT COUNT(*) FROM $_studentTable";
    return Sqflite.firstIntValue(await db.rawQuery(sql));
  }

  //get all Student information from the database
  Future<List> getAllStudent() async {
    var db = await myDb;
    var sql = "SELECT * FROM $_studentTable";
    List result = await db.rawQuery(sql);
    return result.toList();
  }

//close the database
  Future<void> closeStudent() async {
    var db = await myDb;
    return await db.close();
  }
}
