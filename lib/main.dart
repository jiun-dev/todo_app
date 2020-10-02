import 'dart:js';

import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'to do list',
      home: new TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() => _todoItems.add(task)); // ???
    }
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText) {
    return new ListTile(
      title: new Text(todoText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
        ),
        body: _buildTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: Icon(Icons.add),
        ));
  }
}

void _pushAddTodoScreen() {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Task'),
      ),
      body: TextField(
        autofocus: true,
        onSubmitted: (val) {
          _addTodoItem(val);
          Navigator.pop(context);
        },
        decoration: InputDecoration(
            hintText: 'Enter something to do',
            contentPadding: const EdgeInsets.all(16)),
      ),
    );
  }));
}

void _removeTodoItem(int index) {
  setState(() => _todoItems.removeAt(index));
}

// Show an alert dialog asking the user to confirm that the task is done
void _promptRemoveTodoItem(int index) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
            title: new Text('Mark "${_todoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () => Navigator.of(context).pop()),
              new FlatButton(
                  child: new Text('MARK AS DONE'),
                  onPressed: () {
                    _removeTodoItem(index);
                    Navigator.of(context).pop();
                  })
            ]);
      });
}

Widget _buildTodoList() {
  return new ListView.builder(
    itemBuilder: (context, index) {
      if (index < _todoItems.length) {
        return _buildTodoItem(_todoItems[index], index);
      }
    },
  );
}

Widget _buildTodoItem(String todoText, int index) {
  return new ListTile(
      title: new Text(todoText), onTap: () => _promptRemoveTodoItem(index));
}
