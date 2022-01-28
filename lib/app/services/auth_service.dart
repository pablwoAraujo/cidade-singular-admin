import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/services/dio_service.dart';
import 'package:dio/dio.dart';
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
}
