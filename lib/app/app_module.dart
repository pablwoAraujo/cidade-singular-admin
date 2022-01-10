import 'package:cidade_singular_admin/app/screens/home/home_page.dart';
import 'package:cidade_singular_admin/app/screens/singularities/add_singularity_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (ctx, args) => HomePage(),
    ),
    ChildRoute(
      AddSingularityPage.routeName,
      child: (ctx, args) => AddSingularityPage(),
    )
  ];
}
