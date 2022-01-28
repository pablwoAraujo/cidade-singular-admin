import 'package:cidade_singular_admin/app/screens/home/home_page.dart';
import 'package:cidade_singular_admin/app/screens/login/login_page.dart';
import 'package:cidade_singular_admin/app/screens/register/register_page.dart';
import 'package:cidade_singular_admin/app/screens/singularities/add_singularity_page.dart';
import 'package:cidade_singular_admin/app/screens/spash/splash_page.dart';
import 'package:cidade_singular_admin/app/services/auth_service.dart';
import 'package:cidade_singular_admin/app/services/dio_service.dart';
import 'package:cidade_singular_admin/app/services/singularity_service.dart';
import 'package:cidade_singular_admin/app/services/user_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => DioService()),
    Bind((i) => SingularityService(i.get())),
    Bind((i) => AuthService(i.get())),
    Bind((i) => UserService(i.get())),
    Bind((i) => UserStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (ctx, args) => SplashPage(),
    ),
    ChildRoute(
      HomePage.routeName,
      child: (ctx, args) => HomePage(),
    ),
    ChildRoute(
      AddSingularityPage.routeName,
      child: (ctx, args) => AddSingularityPage(),
    ),
    ChildRoute(
      LoginPage.routeName,
      child: (ctx, args) => LoginPage(email: args.data ?? ""),
    ),
    ChildRoute(
      RegisterPage.routeName,
      child: (ctx, args) => RegisterPage(),
    )
  ];
}
