import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/screens/curators/add_curator_dialog.dart';
import 'package:cidade_singular_admin/app/screens/curators/curator_widget.dart';
import 'package:cidade_singular_admin/app/services/user_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';

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
                        left: 16,
                        right: 16,
                        bottom: index == curators.length - 1 ? 140 : 10,
                      ),
                    );
                  }),
          Positioned(
            bottom: 100,
            right: 16,
            child: SpeedDial(
              icon: Icons.add,
              activeIcon: Icons.close,
              overlayColor: Colors.black,
              spacing: 20,
              children: [
                SpeedDialChild(
                  label: "Curador de Música",
                  onTap: () => onTapCuratorType(CuratorType.MUSIC),
                  labelBackgroundColor: Constants.MUSIC,
                  backgroundColor: Constants.MUSIC,
                  child: SvgPicture.asset("assets/images/MUSIC.svg", width: 20),
                ),
                SpeedDialChild(
                  label: "Curador de Cinema",
                  onTap: () => onTapCuratorType(CuratorType.FILM),
                  labelBackgroundColor: Constants.FILM,
                  backgroundColor: Constants.FILM,
                  child: SvgPicture.asset("assets/images/FILM.svg", width: 20),
                ),
                SpeedDialChild(
                  label: "Curador de Literatura",
                  onTap: () => onTapCuratorType(CuratorType.LITERATURE),
                  labelBackgroundColor: Constants.LITERATURE,
                  backgroundColor: Constants.LITERATURE,
                  child: SvgPicture.asset("assets/images/LITERATURE.svg",
                      width: 20),
                ),
                SpeedDialChild(
                  label: "Curador de Artes Midiáticas",
                  onTap: () => onTapCuratorType(CuratorType.ARTS),
                  labelBackgroundColor: Constants.ARTS,
                  backgroundColor: Constants.ARTS,
                  child: SvgPicture.asset("assets/images/ARTS.svg", width: 20),
                ),
                SpeedDialChild(
                  label: "Curador de Gastronomia",
                  onTap: () => onTapCuratorType(CuratorType.GASTRONOMY),
                  labelBackgroundColor: Constants.GASTRONOMY,
                  backgroundColor: Constants.GASTRONOMY,
                  child: SvgPicture.asset("assets/images/GASTRONOMY.svg",
                      width: 20),
                ),
                SpeedDialChild(
                  label: "Curador de Artesanato",
                  onTap: () => onTapCuratorType(CuratorType.CRAFTS),
                  labelBackgroundColor: Constants.CRAFTS,
                  backgroundColor: Constants.CRAFTS,
                  child:
                      SvgPicture.asset("assets/images/CRAFTS.svg", width: 20),
                ),
                SpeedDialChild(
                  label: "Curador de Design",
                  onTap: () => onTapCuratorType(CuratorType.DESIGN),
                  labelBackgroundColor: Constants.DESIGN,
                  backgroundColor: Constants.DESIGN,
                  child:
                      SvgPicture.asset("assets/images/DESIGN.svg", width: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTapCuratorType(CuratorType type) async {
    try {
      bool sholdReload = (await showDialog(
        context: context,
        builder: (context) => AddCuratorDialog(
          curatorType: type.toString().split(".").last,
        ),
      )) as bool;
      if (sholdReload) getUsers();
    } catch (e) {
      print(e);
    }
  }
}
