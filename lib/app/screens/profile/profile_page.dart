import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/screens/login/login_page.dart';
import 'package:cidade_singular_admin/app/services/auth_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = Modular.get();

  UserStore userStore = Modular.get();

  logout() async {
    await authService.logout();
    Modular.to.popAndPushNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          InkWell(
            onTap: logout,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sair"),
                SizedBox(width: 5),
                Icon(Icons.logout_outlined),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Observer(builder: (context) {
          User? user = userStore.user;

          return user == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity),
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        foregroundImage: NetworkImage(user.picture),
                        child: Text(
                          user.name[0],
                          style: TextStyle(fontSize: 38),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 26,
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    buildField(text: user.email, title: "Email"),
                    SizedBox(height: 20),
                    buildField(title: "Descrição", text: user.description),
                    SizedBox(height: 20),
                    buildField(
                        title: "Usuário",
                        text: user.type.value +
                            ((user.type == UserType.CURATOR &&
                                    user.curator_type != null)
                                ? " de " + (user.curator_type?.value ?? "")
                                : "")),
                  ],
                );
        }),
      ),
    );
  }

  Widget buildField({required String title, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Constants.primaryColor,
          ),
        ),
        SizedBox(height: 2),
        TextFormField(
          controller: TextEditingController(text: text),
          readOnly: true,
          textAlign: TextAlign.justify,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: "",
            counterText: "",
            helperMaxLines: 0,
            filled: true,
            fillColor: Constants.grey,
          ),
        ),
      ],
    );
  }
}
