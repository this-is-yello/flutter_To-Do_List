import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/todo.dart';
import 'package:flutter_todo_list/provider/todo_default.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Todo> todos;
  TodoDefault todoDefault = TodoDefault();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print('initState');
    Timer(Duration(seconds: 2), () {
      todos = todoDefault.getTodos();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할 일 목록'),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book),
                  Text('뉴스'),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 25)),
        onPressed: () {
          
        },
      ),
      body: isLoading
            ? Center(
              child: CircularProgressIndicator(),
            )
            : ListView.separated(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].title),
                    onTap: () {},
                    trailing: Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              child: Icon(Icons.edit),
                              onTap: () {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              child: Icon(Icons.delete),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
    );
  }
}

// class ListScreen extends StatefulWidget {
//   @override
//   _ListScreenState createState() => _ListScreenState();
// }

// class _ListScreenState extands State<ListScreen> {
//   List<Todo> todos = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     print('initstate');
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('할 일 목록'),
//         actions: [
//           InkWell(
//             onTap: () {},
//             child: Container(
//               padding: EdgeInsets.all(5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.book),
//                   Text('뉴스'),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Text('+', style: TextStyle(fontSize: 25)),
//         onPressed: () {},
//       ),
//       body: isLoading
//       ? Center(
//         child: CircularProgressIndicator(),
//       )
//       : ListView.separated(
//         itemCount: todos.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(todos[index].title),
//             onTap: () {},
//             trailing: Container(
//               width: 80,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     child: InkWell(
//                       child: Icon(Icons.edit),
//                       onTap: () {},
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     child: InkWell(
//                       child: Icon(Icons.delete),
//                       onTap: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//         separatorBuilder: (context, index) {
//           return Divider();
//         },
//       ),
//     );
//   }
// }