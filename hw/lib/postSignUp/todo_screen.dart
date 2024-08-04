import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hw/generated/l10n.dart';

class todo_screen extends StatefulWidget {
  @override
  todo_screen_state createState() => todo_screen_state();
}

class todo_screen_state extends State<todo_screen> {
  final TextEditingController _todoController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  void _addTodo() async {
    if (_todoController.text.isNotEmpty) {
      await _firestore.collection('todos').add({
        'task': _todoController.text,
        'isDone': false,
        'userId': _currentUser?.uid,
      });
      _todoController.clear();
    }
  }

  void _toggleDone(DocumentSnapshot doc) async {
    await _firestore.collection('todos').doc(doc.id).update({
      'isDone': !doc['isDone'],
    });
  }

  void _deleteTodo(DocumentSnapshot doc) async {
    await _firestore.collection('todos').doc(doc.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Batch16String.current.todo),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(labelText: Batch16String.current.addTodo),
                  ),
                ),
                IconButton(
                   icon: Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('todos')
                  .where('userId', isEqualTo: _currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var todos = snapshot.data!.docs;
                var pendingTodos = todos.where((todo) => !todo['isDone']).toList();
                var doneTodos = todos.where((todo) => todo['isDone']).toList();

                return ListView(
                  children: [
                    ListTile(
                      title: Text(Batch16String.current.pending),
                      tileColor: Colors.grey[300],
                    ),
                    ...pendingTodos.map((todo) {
                      return ListTile(
                        title: Text(todo['task']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: todo['isDone'],
                              onChanged: (bool? value) {
                                _toggleDone(todo);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteTodo(todo);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    ListTile(
                      title: Text(Batch16String.current.done),
                      tileColor: Colors.grey[300],
                    ),
                    ...doneTodos.map((todo) {
                      return ListTile(
                        title: Text(todo['task']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: todo['isDone'],
                              onChanged: (bool? value) {
                                _toggleDone(todo);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteTodo(todo);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
