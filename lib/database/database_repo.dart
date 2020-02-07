import 'dart:async';
import 'todo_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Constants.dart';

class DatabaseRepo{

   Future<Database> getAndOpenDatabase() async{
    var database =  openDatabase(join( await getDatabasesPath(), "todo.db"),
    onCreate: (db, version){
      return db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
    }, version: 1);

    return database;
  }

  Future<void> insertTodo(TodoModel todoModel) async {

    var database = await getAndOpenDatabase();
    return database.insert("todo", todoModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  Future<void> deleteTodo(TodoModel todoModel) async {
    var database = await getAndOpenDatabase();
    return database.delete("todo", where: "id = ${todoModel.id}", whereArgs: [todoModel.id]);
  }

  Future<void> updateTodo(TodoModel todoModel) async {
    var database = await getAndOpenDatabase();
    return database.update("todo", todoModel.toMap(), where: "id = ${todoModel.id}", whereArgs: [todoModel.id]);
  }

  Future<List<TodoModel>> queryOnGoingTodos() async {
     var database = await getAndOpenDatabase();
     final List<Map<String, dynamic>> rawList = await database.query("todo", where: "status=${Constants.ON_GOING}");
     return List.generate(rawList.length, (i){
       return TodoModel(
         id: rawList[i]['id'] as int,
         timeInMillis: rawList[i]['timeInMillis'] as int,
         todoDesc: rawList[i]['todoDesc'] as String,
         todoTitle: rawList[i]['todoTitle'] as String,
         status: rawList[i]['status'] as String
       );
     });
  }

   Future<List<TodoModel>> queryCompletedTodos() async {
     var database = await getAndOpenDatabase();
     final List<Map<String, dynamic>> rawList = await database.query("todo", where: "status=${Constants.COMPLETED}");
     return List.generate(rawList.length, (i){
       return TodoModel(
           id: rawList[i]['id'] as int,
           timeInMillis: rawList[i]['timeInMillis'] as int,
           todoDesc: rawList[i]['todoDesc'] as String,
           todoTitle: rawList[i]['todoTitle'] as String,
           status: rawList[i]['status'] as String
       );
     });
   }

}