import 'package:cidade_singular_admin/app/screens/home/home_page.dart';
import 'package:cidade_singular_admin/app/screens/login/login_page.dart';
import 'package:cidade_singular_admin/app/services/auth_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthService authService = Modular.get();
  UserStore userStore = Modular.get();

  @override
  void initState() {
    authService.me().then((user) {
      if (user != null) {
        userStore.setUser(user);
        Modular.to.popAndPushNamed(HomePage.routeName);
      } else {
        Modular.to.popAndPushNamed(LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
