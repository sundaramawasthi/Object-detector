import 'package:flutter/material.dart';
import 'pageroute.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showGeneralDialog(
      barrierColor: Colors.indigo.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1;
        return Transform(
          transform: Matrix4.translationValues(0, curvedValue * 200, 0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text('Mark ${_todoItems[index]} as done?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Future.delayed(Duration(milliseconds: 2200), () {
                      _removeTodoItem(index);
                    });
                  },
                  child: Text('Mark as done'),
                ),
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 1500),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SizedBox();
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4,
      ),
      child: ListTile(
        tileColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          todoText,
          style: TextStyle(color: Colors.white),
        ),
        onTap: () => _promptRemoveTodoItem(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          if (index < _todoItems.length) {
            return _buildTodoItem(_todoItems[index], index);
          }
          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.push(
      context,
      BouncyPageRoute(
        widget: Scaffold(
          appBar: AppBar(
            title: Text('Add a new task'),
          ),
          body: TextField(
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              hintText: 'Enter something todo',
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
      ),
    );
  }
}
