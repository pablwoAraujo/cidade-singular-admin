import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/screens/curators/add_curator_dialog.dart';
import 'package:cidade_singular_admin/app/screens/curators/curator_widget.dart';
import 'package:cidade_singular_admin/app/services/user_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CuratorsPage extends StatefulWidget {
  const CuratorsPage({Key? key}) : super(key: key);

  @override
  _CuratorsPageState createState() => _CuratorsPageState();
}

class _CuratorsPageState extends State<CuratorsPage> {
  UserService service = Modular.get();

  UserStore userStore = Modular.get();

  bool loading = false;
  List<User> curators = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() async {
    setState(() => loading = true);
    curators = await service.getUsers(query: {
      "type": UserType.CURATOR.toString().split(".").last,
      "curator_type":
          userStore.user?.curator_type.toString().split(".").last ?? "",
      "city": userStore.user?.city?.id ?? ""
    });
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Curadores"),
        leading: Container(),
      ),
      body: Stack(
        children: [
          loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: curators.length,
                  itemBuilder: (context, index) {
                    User user = curators[index];
                    return CuratorWidget(
                      user: user,
                      margin: EdgeInsets.only(
                          left: 16, right: 16, bottom: index == 9 ? 140 : 10),
                    );
                  }),
          Positioned(
            bottom: 100,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Constants.primaryColor,
              onPressed: () async {
                try {
                  bool sholdReload = (await showDialog(
                      context: context,
                      builder: (context) => AddCuratorDialog())) as bool;
                  if (sholdReload) getUsers();
                } catch (e) {}
              },
              child: Text(
                "+",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
