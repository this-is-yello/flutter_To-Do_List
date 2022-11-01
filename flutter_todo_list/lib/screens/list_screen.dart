import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/todo.dart';
import 'package:flutter_todo_list/providers/todo_default.dart';
import 'package:flutter_todo_list/providers/todo_firestore.dart';
import 'package:flutter_todo_list/providers/todo_sqlite.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos = [];
  // TodoDefault todoDefault = TodoDefault();
  // TodoSqlite todoSqlite = TodoSqlite();
  TodoFirebase todoFirebase = TodoFirebase();

     CollectionReference todosReference= FirebaseFirestore.instance.collection('todos');
  late Stream<QuerySnapshot> todoStream;


  // bool isLoading = true;

  // Future initDb() async {
  //   await todoSqlite.initDb().then((value) async {
  //     todos = await todoSqlite.getTodos();
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   print('initState');
  //   Timer(Duration(seconds: 2), () {
  //     // todos = todoDefault.getTodos();
  //     initDb().then((_) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     });
  //   });
  // }
  @override
  void initState() {
   
    super.initState();
    todoStream = todosReference.snapshots();
    setState(() {
      todoFirebase.initDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: todoFirebase.todoStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          todos = todoFirebase.getTodos(snapshot);
          return Scaffold(
            appBar: AppBar(
              title: Text('할 일 목록'),
            ),
          );
        }
      }
    );

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('할 일 목록'),
  //       actions: [
  //         InkWell(
  //           onTap: () {},
  //           child: Container(
  //             padding: EdgeInsets.all(5),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(Icons.book),
  //                 Text('뉴스'),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       child: Text('+', style: TextStyle(fontSize: 25)),
  //       onPressed: () {
  //         showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               String title = '';
  //               String description = '';
  //               return AlertDialog(
  //                 title: Text('할 일 추가하기'),
  //                 content: Container(
  //                   height: 200,
  //                   child: Column(
  //                     children: [
  //                       TextField(
  //                         onChanged: (value) {
  //                           title = value;
  //                         },
  //                         decoration: InputDecoration(labelText: '제목'),
  //                       ),
  //                       TextField(
  //                         onChanged: (value) {
  //                           description = value;
  //                         },
  //                         decoration: InputDecoration(labelText: '설명'),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                       child: Text('추가'),
  //                       onPressed: () async {
  //                         await todoSqlite.addTodo(
  //                           Todo(title: title, description: description),
  //                         );
  //                         List<Todo> newTodos = await todoSqlite.getTodos();
  //                         setState(() {
  //                           print('[UI] ADD');
  //                           todos = newTodos;
  //                           // todoDefault.addTodo(
  //                           //   Todo(title: title, description: description),
  //                           // );
  //                         });
  //                         Navigator.of(context).pop();
  //                       }),
  //                   TextButton(
  //                       child: Text('취소'),
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                       }),
  //                 ],
  //               );
  //             });
  //       },
  //     ),
  //     body: isLoading
  //         ? Center(
  //             child: CircularProgressIndicator(),
  //           )
  //         : ListView.separated(
  //             itemCount: todos.length,
  //             itemBuilder: (context, index) {
  //               return ListTile(
  //                 title: Text(todos[index].title),
  //                 onTap: () {
  //                   showDialog(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return SimpleDialog(
  //                           title: Text('할 일'),
  //                           children: [
  //                             Container(
  //                               padding: EdgeInsets.all(10),
  //                               child: Text('설명 : ' + todos[index].title),
  //                             ),
  //                             Container(
  //                               padding: EdgeInsets.all(10),
  //                               child: Text('설명 : ' + todos[index].description),
  //                             ),
  //                           ],
  //                         );
  //                       });
  //                 },
  //                 trailing: Container(
  //                   width: 80,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.all(5),
  //                         child: InkWell(
  //                           child: Icon(Icons.edit),
  //                           onTap: () {
  //                             showDialog(
  //                                 context: context,
  //                                 builder: (BuildContext context) {
  //                                   String title = todos[index].title;
  //                                   String description =
  //                                       todos[index].description;
  //                                   return AlertDialog(
  //                                     title: Text('할 일 수정하기'),
  //                                     content: Container(
  //                                       height: 200,
  //                                       child: Column(
  //                                         children: [
  //                                           TextField(
  //                                             onChanged: (value) {
  //                                               title = value;
  //                                             },
  //                                             decoration: InputDecoration(
  //                                               hintText: todos[index].title,
  //                                             ),
  //                                           ),
  //                                           TextField(
  //                                             onChanged: (value) {
  //                                               description = value;
  //                                             },
  //                                             decoration: InputDecoration(
  //                                               hintText:
  //                                                   todos[index].description,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     actions: [
  //                                       TextButton(
  //                                           child: Text('수정'),
  //                                           onPressed: () async {
  //                                             Todo newTodo = Todo(
  //                                               id: todos[index].id,
  //                                               title: title,
  //                                               description: description,
  //                                             );
  //                                             await todoSqlite.updateTodo(newTodo);
  //                                             List<Todo> newTodos = await todoSqlite.getTodos();
  //                                             setState(() {
  //                                               // todoDefault.updateTodo(newTodo);
  //                                               todos = newTodos;
  //                                             });
  //                                             Navigator.of(context).pop();
  //                                           }),
  //                                     ],
  //                                   );
  //                                 });
  //                           },
  //                         ),
  //                       ),
  //                       Container(
  //                         padding: EdgeInsets.all(5),
  //                         child: InkWell(
  //                           child: Icon(Icons.delete),
  //                           onTap: () {
  //                             showDialog(
  //                               context: context,
  //                               builder: (BuildContext context) {
  //                                 return AlertDialog(
  //                                   title: Text('할 일 삭제하기'),
  //                                   content: Container(
  //                                     child: Text('삭제하시겠습니까?'),
  //                                   ),
  //                                   actions: [
  //                                     TextButton(
  //                                       child: Text('삭제'),
  //                                       onPressed: () async {
  //                                         await todoSqlite.deleteTodo(
  //                                           todos[index].id ?? 0
  //                                         );
  //                                         List<Todo> newTodos = await todoSqlite.getTodos();
  //                                         setState(() {
  //                                           todos = newTodos;
  //                                           // todoDefault.deleteTodo(
  //                                           //   todos[index].id ?? 0
  //                                           // );
  //                                         });
  //                                         Navigator.of(context).pop();
  //                                       }
  //                                     ),
  //                                     TextButton(
  //                                       child: Text('취소'),
  //                                       onPressed: () {
  //                                         Navigator.of(context).pop();
  //                                       }
  //                                     ),
  //                                   ],
  //                                 );
  //                               }
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //             separatorBuilder: (context, index) {
  //               return Divider();
  //             },
  //           ),
  //   );
   }
}