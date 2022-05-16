import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/providers/todos_provider.dart';

class UpdateTodoScreen extends StatelessWidget {
  UpdateTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _todosProvider = context.watch<TodosProvider>();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String title = args['title'];
    String id = args['id'].toString();
    String userId = args['userId'].toString();
    int index = args['index'];

    TextEditingController _titleController = TextEditingController(text: title);
    TextEditingController _idController =
        TextEditingController(text: id.toString());
    TextEditingController _userIdController =
        TextEditingController(text: userId.toString());

    print(title.toString());
    print(args);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 176, 174, 174),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 21, 37),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Update Todos",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "UserId:",
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 21, 37),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _userIdController,
                      decoration: InputDecoration(
                          hintText: "userId", border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "ID:",
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 21, 37),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                          hintText: "id", border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Title:",
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 21, 37),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          hintText: "title", border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Color.fromARGB(255, 1, 21, 37),
                  onPressed: () {
                    context.read<TodosProvider>().updateTodos(
                          title: _titleController.text,
                          id: int.parse(_idController.text),
                          userId: int.parse(_userIdController.text),
                          index: index,
                          
                        );
                    if (_todosProvider.hasCreateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Upadate failed")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Upadated Sucessfully")));
                      // context.read<TodosProvider>().fetchTodos();

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
