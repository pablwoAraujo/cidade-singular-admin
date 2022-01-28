import 'dart:convert';
import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  DioService dioService;

  UserService(this.dioService);

  Future<User?> me() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (token == null) {
        return null;
      } else {
        dioService.addToken(token);
      }
      var response = await dioService.dio.get("/user/me");

      if (response.data["error"]) {
        return null;
      } else {
        return User.fromMap(response.data["user"]);
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      } else {
        print(e);
      }
      return null;
    }
  }

  Future<bool> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      var response = await dioService.dio.post(
        "/user",
        data: {
          "email": email,
          "password": password,
          "name": name,
        },
      );

      if (response.data["error"]) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      }
      return false;
    }
  }

  Future<User?> update({
    String? name,
    String? description,
    XFile? photo,
    String? type,
    String? curator_type,
    String? city,
    required String id,
  }) async {
    try {
      var response = await dioService.dio.put(
        "/user/$id",
        data: {
          if (name != null) "name": name,
          if (description != null) "description": description,
          if (photo != null) "picture": base64Encode(await photo.readAsBytes()),
          if (type != null) "type": type,
          if (curator_type != null) "curator_type": curator_type,
          if (city != null) "city": city,
        },
      );

      if (response.data["error"]) {
        return null;
      } else {
        return User.fromMap(response.data["item"]);
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      } else {
        print(e);
      }
      return null;
    }
  }

  Future<List<User>> getUsers({Map<String, String> query = const {}}) async {
    try {
      var response = await dioService.dio.get(
        "/user",
        queryParameters: query,
      );

      if (response.data["error"]) {
        return [];
      } else {
        List<User> users = [];
        for (Map data in response.data["data"]) {
          users.add(User.fromMap(data));
        }
        return users;
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      } else {
        print(e);
      }
      return [];
    }
  }
}
