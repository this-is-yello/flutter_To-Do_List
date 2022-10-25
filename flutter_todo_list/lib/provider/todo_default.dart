import 'package:flutter_todo_list/models/todo.dart';

class TodoDefault {
  List<Todo> dummyTodos = [
    Todo(id: 1, title: '데일리 업무', description: '스마트 플레이스, 온라인쇼핑몰 , 채팅상담 문의'),
    Todo(id: 2, title: '디자인 레퍼런스 카피 작업', description: '디자인 레퍼런스 카피'),
    Todo(id: 3, title: '고객장부 엑셀 자동화 만들기', description: '고객장부 엑셀 자동화 만들기'),
    Todo(id: 4, title: '플러터', description: 'to-do 리스트'),
  ];

  List<Todo> getTodos() {
    return dummyTodos;
  }

  Todo getTodo(int id) {
    return dummyTodos[id];
  }

  Todo addTodo(Todo todo) {
    Todo newTodo = Todo(
        id: dummyTodos.length + 1,
        title: todo.title,
        description: todo.description);
    dummyTodos.add(newTodo);
    return newTodo;
  }

  void deleteTodo(int id) {
    for (int i = 0; i < dummyTodos.length; i++) {
      if (dummyTodos[i].id == id) {
        dummyTodos.removeAt(i);
      }
    }
  }

  void updateTodo(Todo todo) {
    for (int i = 0; i < dummyTodos.length; i++) {
      if (dummyTodos[i].id == todo.id) {
        dummyTodos[i] = todo;
      }
    }
  }
}
