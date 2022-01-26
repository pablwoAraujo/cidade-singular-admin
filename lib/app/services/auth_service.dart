import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  DioService dioService;

  AuthService(this.dioService);

  Future<bool> login({required String email, required String password}) async {
    try {
      var response = await dioService.dio.post(
        "/user/auth",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.data["token"] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", response.data["token"]);
        dioService.addToken(response.data["token"]);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      }
      return false;
    }
  }

  Future logout() async {
    dioService.removeToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

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
}
