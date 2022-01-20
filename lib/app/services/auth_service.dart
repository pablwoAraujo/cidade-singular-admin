import 'package:cidade_singular_admin/app/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthService {
  DioService dioService = Modular.get();

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
