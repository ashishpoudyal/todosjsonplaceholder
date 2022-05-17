import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/notification_api.dart';
import 'package:todos_app/providers/todos_provider.dart';

class CreateTodosScreen extends StatelessWidget {
  CreateTodosScreen({Key? key}) : super(key: key);
  bool isLoading = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _todosProvider = context.watch<TodosProvider>();

    isLoading = _todosProvider.isCreatingData;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 176, 174, 174),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 21, 37),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Create Todos",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "UserId :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
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
                        hintText: "usrId", border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ID :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
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
                height: 25,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Title :",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
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
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await context.read<TodosProvider>().createTodos(
                              id: int.parse(_idController.text),
                              userId: int.parse(_userIdController.text),
                              title: _titleController.text,
                            );

                        if (_todosProvider.hasCreateError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(_todosProvider.createErrorMessage)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Created Sucessfully")));
                          // context.read<TodosProvider>().fetchTodos();
                          
                          Navigator.pop(context);
                        }
                      },
                      color: Color.fromARGB(255, 1, 21, 37),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
