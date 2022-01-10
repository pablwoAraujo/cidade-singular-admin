import 'package:cidade_singular_admin/app/screens/singularities/add_singularity_page.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class SingularitiesPage extends StatefulWidget {
  const SingularitiesPage({Key? key}) : super(key: key);

  @override
  _SingularitiesPageState createState() => _SingularitiesPageState();
}

class _SingularitiesPageState extends State<SingularitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Singularidades"),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          backgroundColor: Constants.primaryColor,
          onPressed: () {
            Modular.to.pushNamed(AddSingularityPage.routeName);
          },
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(
                left: 16, right: 16, bottom: index == 9 ? 140 : 10),
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      "https://www.paraibacriativa.com.br/wp-content/uploads/2015/08/edifica----es_museu_dos_tr--s_pandeiros1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Museu dos três pandeiros",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Constants.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/places.svg",
                              width: 16,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                "R. Dr. Severino Cruz, s/n - Centro, Campina Grande - PB, 58400-258",
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/hour.svg",
                              width: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "09:20 - 22:00",
                              softWrap: false,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 25,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 1,
                                        color: Colors.black26,
                                      )
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Remover",
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    SvgPicture.asset(
                                      "assets/images/trash.svg",
                                      width: 16,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
