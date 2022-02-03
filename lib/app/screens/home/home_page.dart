import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/screens/curators/curators_page.dart';
import 'package:cidade_singular_admin/app/screens/profile/profile_page.dart';
import 'package:cidade_singular_admin/app/screens/singularities/singularities_page.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  static String routeName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  int currentPage = 0;

  UserStore userStore = Modular.get();

  @override
  void initState() {
    pageController.addListener(() {
      int next = pageController.page?.round() ?? 0;
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserType userType = userStore.user?.type ?? UserType.VISITOR;
    List<MenuPage> pages = [
      if (userType != UserType.VISITOR)
        MenuPage(
          name: "Singular",
          svgIconPath: "assets/images/places.svg",
          page: SingularitiesPage(),
        ),
      if (userType == UserType.MANAGER || userType == UserType.ADMIN)
        MenuPage(
          name: "Curadores",
          icon: Icons.people_rounded,
          page: CuratorsPage(),
        ),
      MenuPage(
        name: "Perfil",
        icon: Icons.person,
        page: ProfilePage(),
      ),
    ];

    List<Widget> menuItens = [];
    for (int i = 0; i < pages.length; i++) {
      MenuPage page = pages[i];
      menuItens.add(menuItemWidget(
        selected: currentPage == i,
        title: page.name,
        icon: page.icon,
        svgIconPath: page.svgIconPath,
        onPressed: () => pageController.jumpToPage(i),
      ));
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              children: pages.map((p) => p.page).toList(),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 70,
                margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(4, 4),
                      blurRadius: 5,
                      color: Colors.black26,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuItens,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menuItemWidget({
    required String title,
    required VoidCallback onPressed,
    IconData? icon,
    String? svgIconPath,
    bool selected = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgIconPath == null
                ? Icon(
                    icon,
                    size: selected ? 26 : 22,
                    color: selected
                        ? Constants.primaryColor
                        : Constants.disableColor,
                  )
                : SvgPicture.asset(
                    svgIconPath,
                    color: selected
                        ? Constants.primaryColor
                        : Constants.disableColor,
                    width: selected ? 26 : 22,
                    height: selected ? 26 : 22,
                  ),
            Text(
              title,
              style: TextStyle(
                color:
                    selected ? Constants.primaryColor : Constants.disableColor,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage {
  String name;
  IconData? icon;
  String? svgIconPath;
  Widget page;

  MenuPage({
    required this.name,
    required this.page,
    this.icon,
    this.svgIconPath,
  });
}
