import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todos_app/model/todos_model.dart';
import 'package:todos_app/notification_api.dart';

class TodosProvider extends ChangeNotifier {
  final _dio = Dio();
  List<Todos> _todos = [];
  List<Todos> get todos => _todos;

  bool _isFetchData = false;
  bool get isFetchData => _isFetchData;

  bool _hasError = false;
  bool get hasError => _hasError;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isCreatingData = false;
  bool get isCreatingData => _isCreatingData;
  bool _hasCreateError = false;
  bool get hasCreateError => _hasCreateError;

  String _createErrorMessage = "";
  String get createErrorMessage => _createErrorMessage;
  _resetGetStatus() {
    _isFetchData = false;
    _hasError = false;
    _errorMessage = "";
  }

  _resetCreateStatus() {
    _isCreatingData = false;
    _hasCreateError = false;
    _createErrorMessage = "";
  }

  fetchTodos() async {
    try {
      _resetGetStatus();
      _isCreatingData = true;

      print(_isCreatingData);
      final response =
          await _dio.get("https://jsonplaceholder.typicode.com/todos");
      if (response.statusCode == 200) {
        final _temp = response.data;

        final _data = List.from(_temp);
        _todos = _data.map((e) => Todos.fromJson(e)).toList();
        print("_todos data format");
        print(_todos);
      } else {
        _hasError = true;
        _errorMessage = "serve errror";
      }
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    } finally {
      _isFetchData = false;
      notifyListeners();
    }
  }

  Future<void> createTodos(
      {required String title, required int userId, required int id}) async {
    try {
      final _body = {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": false,
      };
      _resetCreateStatus();

      _isCreatingData = true;
      final _response = await _dio.post(
        "https://jsonplaceholder.typicode.com/todos",
        data: _body,
      );
      print(_response.data);
      print(_response.statusCode);
      if (_response.statusCode == 201) {
        _isCreatingData = false;
        print("response after fromjson");
        print(Todos.fromJson(_response.data));
        Todos resTodo = Todos.fromJson(_response.data);

        _todos.insert(0, resTodo);
        NotificationApi.showNotification(
          title: "Todos created sucessfully",
          body: resTodo.title,
        );

        print(resTodo);
      } else {
        print("heeeeeeeeeeeeee");
        _hasCreateError = true;
        _createErrorMessage = "unable to save todos";
      }
    } catch (e) {
      print("hmmmmmm catch");
      print(e.toString());
      _hasCreateError = true;
      _createErrorMessage = e.toString();
    } finally {
      _isCreatingData = false;
      notifyListeners();
    }
  }

  Future<void> updateTodos({
    required String title,
    required int userId,
    required int id,
    required int index,
  }) async {
    try {
      final _body = {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": false,
      };
      _resetCreateStatus();
      _isCreatingData = true;
      final _response = await _dio.put(
        "https://jsonplaceholder.typicode.com/todos/1",
        data: _body,
      );
      Todos updateResponse = Todos.fromJson(_response.data);
      print(_response.data);
      print(_response.statusCode);
      if (_response.statusCode == 200) {
        print("hell");

        _isCreatingData = false;

        _todos[index] = updateResponse;
        NotificationApi.showNotification(
          title: "Todos updated sucessfully",
          body: updateResponse.title,
        );
      } else {
        print("heeeeeeeeeeeeee");
        _hasCreateError = true;
        _createErrorMessage = "unable to update todos";
      }
    } catch (e) {
      print("hmmmmmm catch");
      print(e.toString());
      _hasCreateError = true;
      _createErrorMessage = e.toString();
    } finally {
      _isCreatingData = false;
      notifyListeners();
    }
  }

  Future<void> deleteTodos({required int id, required int index}) async {
    try {
      _resetCreateStatus();
      _isCreatingData = true;

      final _response = await _dio.delete(
        "https://jsonplaceholder.typicode.com/todos/1",
      );
      print(_response.data);
      print(_response.statusCode);
      if (_response.statusCode == 200) {
        _isCreatingData = false;
        _todos.removeAt(index);
        NotificationApi.showNotification(
          title: "Todos deleted sucessfully",
          body: "",
        );
      } else {
        _hasCreateError = true;
        _createErrorMessage = "unable to update todos";
      }
    } catch (e) {
      print(e.toString());
      _hasCreateError = true;
      _createErrorMessage = e.toString();
    } finally {
      _isCreatingData = false;
      notifyListeners();
    }
  }
}
