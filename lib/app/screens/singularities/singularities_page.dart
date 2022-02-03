import 'package:cidade_singular_admin/app/models/singularity.dart';
import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/screens/singularities/add_singularity_page.dart';
import 'package:cidade_singular_admin/app/screens/singularities/singularity_widget.dart';
import 'package:cidade_singular_admin/app/services/singularity_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SingularitiesPage extends StatefulWidget {
  const SingularitiesPage({Key? key}) : super(key: key);

  @override
  _SingularitiesPageState createState() => _SingularitiesPageState();
}

class _SingularitiesPageState extends State<SingularitiesPage> {
  SingularityService service = Modular.get();

  UserStore userStore = Modular.get();

  bool loading = false;
  List<Singularity> singularities = [];

  @override
  void initState() {
    getSingularites();
    super.initState();
  }

  getSingularites() async {
    setState(() => loading = true);
    User? user = userStore.user;
    UserType userType = userStore.user?.type ?? UserType.VISITOR;
    if (userType == UserType.CURATOR) {
      singularities =
          await service.getSingularities(query: {"creator": user?.id ?? ""});
    } else {
      singularities =
          await service.getSingularities(query: {"city": user?.city?.id ?? ""});
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    UserType userType = userStore.user?.type ?? UserType.VISITOR;
    bool canAddSingularity = userType == UserType.CURATOR;
    return Scaffold(
      appBar: AppBar(
        title: Text("Singularidades"),
        leading: Container(),
      ),
      body: Stack(
        children: [
          loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: singularities.length,
                  itemBuilder: (context, index) {
                    Singularity sing = singularities[index];
                    return SingularityWidget(
                      sing: sing,
                      onDelete: getSingularites,
                      margin: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: index == singularities.length - 1 ? 140 : 10,
                      ),
                    );
                  }),
          if (canAddSingularity)
            Positioned(
              bottom: 100,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Constants.primaryColor,
                onPressed: () async {
                  try {
                    bool sholdReload = (await Modular.to
                        .pushNamed(AddSingularityPage.routeName)) as bool;
                    if (sholdReload) getSingularites();
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
