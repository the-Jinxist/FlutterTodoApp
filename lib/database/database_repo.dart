import 'dart:async';
import 'todo_model.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Constants.dart';

class DatabaseRepo{

   Future<Database> _getAndOpenDatabase() async{
    var database =  openDatabase(join( await getDatabasesPath(), "todo.db"),
    onCreate: (db, version){
      return db.execute("CREATE TABLE todo(id INTEGER PRIMARY KEY, todoDesc TEXT, todoTitle TEXT, timeInMillis INTEGER, status TEXT)");
    }, version: 1);

    return database;
  }

  Future<void> insertTodo(TodoModel todoModel) async {

    var database = await _getAndOpenDatabase();
    return database.insert("todo", todoModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  Future<void> deleteTodo(TodoModel todoModel) async {
    var database = await _getAndOpenDatabase();
    return database.delete("todo", where: "id = ${todoModel.id}");
  }

  Future<void> updateTodo(TodoModel todoModel) async {
    var database = await _getAndOpenDatabase();
    return database.update("todo", todoModel.toMap(), where: "id = ${todoModel.id}");
  }

  Future<List<TodoModel>> queryOnGoingTodos() async {
     var database = await _getAndOpenDatabase();
     final List<Map<String, dynamic>> rawList = await database.query("todo");
     var rawTodoList =  List.generate(rawList.length, (i){
       return TodoModel(
         id: rawList[i]['id'] as int,
         timeInMillis: rawList[i]['timeInMillis'] as int,
         todoDesc: rawList[i]['todoDesc'] as String,
         todoTitle: rawList[i]['todoTitle'] as String,
         status: rawList[i]['status'] as String
       );
     });

     var filteredTodoList = List<TodoModel>();
     for(TodoModel todo in rawTodoList){
       if(todo.status == Constants.ON_GOING) filteredTodoList.add(todo);
     }

     return filteredTodoList;
  }

   Future<List<TodoModel>> queryCompletedTodos() async {
     var database = await _getAndOpenDatabase();
     final List<Map<String, dynamic>> rawList = await database.query("todo");
     var rawTodoList =  List.generate(rawList.length, (i){
       return TodoModel(
           id: rawList[i]['id'] as int,
           timeInMillis: rawList[i]['timeInMillis'] as int,
           todoDesc: rawList[i]['todoDesc'] as String,
           todoTitle: rawList[i]['todoTitle'] as String,
           status: rawList[i]['status'] as String
       );
     });

     var filteredTodoList = List<TodoModel>();
     for(TodoModel todo in rawTodoList){
       if(todo.status == Constants.COMPLETED) filteredTodoList.add(todo);
     }

     return filteredTodoList;
   }

}