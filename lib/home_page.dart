import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/model/todos_model.dart';
import 'package:todos_app/notification_api.dart';
import 'package:todos_app/providers/todos_provider.dart';
import 'package:todos_app/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState

    context.read<TodosProvider>().fetchTodos();
    NotificationApi.init();
  }

  @override
  Widget build(BuildContext context) {
    final _todosProvider = context.watch<TodosProvider>();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 176, 174, 174),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 21, 37),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Todos App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (_todosProvider.isFetchData) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (_todosProvider.hasError) {
            return Center(child: Text("has error"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 15,
                ),
                itemCount: _todosProvider.todos.length,
                itemBuilder: (context, index) => Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, routes().updateTodos,
                              arguments: {
                                'title': _todosProvider.todos[index].title,
                                'id': _todosProvider.todos[index].id,
                                'userId': _todosProvider.todos[index].userId,
                                'completed':
                                    _todosProvider.todos[index].completed,
                                'index': index,
                              });
                        },
                        title: Text(
                          _todosProvider.todos[index].title,
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 21, 37),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              decoration: _todosProvider.todos[index].completed
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        subtitle: Text("Id : " +
                            _todosProvider.todos[index].id.toString()),
                        leading: Column(
                          children: [
                            Text(
                              "User Id\n" +
                                  _todosProvider.todos[index].userId.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              context.read<TodosProvider>().deleteTodos(
                                  id: _todosProvider.todos[index].id,
                                  index: index);

                              if (_todosProvider.hasCreateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("cant delete")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(" deleted Sucessfully")));
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ))),
                  ),
                ),
              ),
            );
          }
        }
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 1, 21, 37),
        onPressed: () {
          Navigator.pushNamed(context, routes().createTodos);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
