import 'package:cidade_singular_admin/app/models/singularity.dart';
import 'package:cidade_singular_admin/app/screens/singularities/add_singularity_page.dart';
import 'package:cidade_singular_admin/app/screens/singularities/singularity_widget.dart';
import 'package:cidade_singular_admin/app/services/singularity_service.dart';
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

  bool loading = false;
  List<Singularity> singularities = [];

  @override
  void initState() {
    getSingularites();
    super.initState();
  }

  getSingularites() async {
    setState(() => loading = true);
    singularities = await service.getSingularities();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
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
