import 'package:cidade_singular_admin/app/screens/singularities/singularities_page.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  int currentPage = 0;

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

  List<MenuPage> pages = [
    MenuPage(
      name: "Lugares",
      svgIconPath: "assets/images/places.svg",
      page: SingularitiesPage(),
    ),
    MenuPage(
      name: "Page 2",
      icon: Icons.ac_unit,
      page: Scaffold(backgroundColor: Colors.greenAccent),
    ),
    MenuPage(
      name: "Page 3",
      icon: Icons.list,
      page: Scaffold(backgroundColor: Colors.yellowAccent),
    )
  ];

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
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
              height: 75,
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
    );
  }

  Widget menuItemWidget({
    required String title,
    required VoidCallback onPressed,
    IconData? icon,
    String? svgIconPath,
    bool selected = false,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          svgIconPath == null
              ? Icon(
                  Icons.home,
                  size: selected ? 28 : 24,
                  color: selected
                      ? Constants.primaryColor
                      : Constants.disableColor,
                )
              : SvgPicture.asset(
                  svgIconPath,
                  color: selected
                      ? Constants.primaryColor
                      : Constants.disableColor,
                  width: selected ? 28 : 24,
                  height: selected ? 28 : 24,
                ),
          Text(
            title,
            style: TextStyle(
              color: selected ? Constants.primaryColor : Constants.disableColor,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
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
