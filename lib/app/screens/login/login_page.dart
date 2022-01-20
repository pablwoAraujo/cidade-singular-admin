import 'package:cidade_singular_admin/app/screens/home/home_page.dart';
import 'package:cidade_singular_admin/app/screens/register/register_page.dart';
import 'package:cidade_singular_admin/app/services/auth_service.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  String email;
  LoginPage({Key? key, this.email = ""}) : super(key: key);

  static String routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();

  @override
  initState() {
    emailController.text = widget.email;
    if (widget.email != "") passwordFocusNode.requestFocus();
    super.initState();
  }

  @override
  dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loginError = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(2, 2),
              )
            ],
          ),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 26,
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                buildFormField(
                  controller: emailController,
                  field: "Email",
                  hintText: "email@exemplo.com",
                  prefix: Icons.person,
                ),
                SizedBox(height: 10),
                buildFormField(
                  controller: passwordController,
                  field: "Senha",
                  hintText: "****",
                  prefix: Icons.lock,
                  obscureText: true,
                  focus: passwordFocusNode,
                ),
                if (loginError)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Email ou senha incorretos, tente novamente!",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ),
                SizedBox(height: 30),
                loading
                    ? Center(child: CircularProgressIndicator())
                    : InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                            loginError = false;
                          });
                          if (_formKey.currentState!.validate()) {
                            bool logged = await authService.login(
                                email: emailController.text,
                                password: passwordController.text);
                            if (logged) {
                              Modular.to.popAndPushNamed(HomePage.routeName);
                            } else {
                              setState(() {
                                loginError = true;
                              });
                            }
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Constants.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white38,
                                blurRadius: 2,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () =>
                      Modular.to.popAndPushNamed(RegisterPage.routeName),
                  child: Column(
                    children: [
                      Text(
                        "Ainda não possui conta?",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontSize: 14,
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormField({
    required TextEditingController controller,
    required String field,
    required String hintText,
    required IconData prefix,
    bool obscureText = false,
    String? Function(String?)? validator,
    FocusNode? focus,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field,
          style: TextStyle(
            fontSize: 14,
            color: Constants.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          focusNode: focus,
          obscureText: obscureText,
          controller: controller,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "Campo não pode ser vazio";
                }
                return null;
              },
          textAlign: TextAlign.justify,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: hintText,
            counterText: "",
            helperMaxLines: 0,
            filled: true,
            fillColor: Constants.grey,
            prefixIcon: Icon(prefix),
          ),
        ),
      ],
    );
  }
}
