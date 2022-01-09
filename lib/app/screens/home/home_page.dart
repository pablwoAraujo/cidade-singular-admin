import 'package:cidade_singular_admin/app/screens/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
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
      name: "Page 1",
      icon: Icons.home,
      page: Scaffold(backgroundColor: Colors.blueAccent),
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
        onPressed: () => pageController.jumpToPage(i),
      ));
    }
    return Scaffold(
      bottomNavigationBar: Container(
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
      body: PageView(
        controller: pageController,
        children: pages.map((p) => p.page).toList(),
      ),
    );
  }

  Widget menuItemWidget({
    required String title,
    required VoidCallback onPressed,
    required IconData icon,
    bool selected = false,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: selected ? 28 : 24,
            color: selected ? Colors.indigo : Color(0xFF898A96),
          ),
          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.indigo : Color(0xFF898A96),
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
  IconData icon;
  Widget page;

  MenuPage({required this.name, required this.icon, required this.page});
}
