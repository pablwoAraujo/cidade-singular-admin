import 'package:cidade_singular_admin/app/screens/login/login_page.dart';
import 'package:cidade_singular_admin/app/services/user_service.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static String routeName = "/register";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  UserService userService = Modular.get();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                    "Cadastro",
                    style: TextStyle(
                      fontSize: 26,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  buildFormField(
                    controller: usernameController,
                    field: "Nome",
                    hintText: "username",
                    prefix: Icons.person,
                  ),
                  SizedBox(height: 10),
                  buildFormField(
                    controller: emailController,
                    field: "Email",
                    hintText: "email@exemplo.com",
                    prefix: Icons.person,
                    validator: (email) {
                      if (!RegExp(r".+\@.+\..+").hasMatch(email ?? "")) {
                        return "Email inválido";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  buildFormField(
                    controller: passwordController,
                    field: "Senha",
                    hintText: "****",
                    prefix: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 10),
                  buildFormField(
                    controller: repeatPasswordController,
                    field: "Repita a senha",
                    hintText: "****",
                    prefix: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return "Senhas não coincidem";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : InkWell(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });

                            if (_formKey.currentState!.validate()) {
                              bool registered = await userService.register(
                                email: emailController.text,
                                password: passwordController.text,
                                name: usernameController.text,
                              );
                              if (registered) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(milliseconds: 500),
                                    backgroundColor: Colors.green.shade800,
                                    content: Text(
                                      "Usuário cadastrado com sucesso!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                                await Future.delayed(
                                    Duration(milliseconds: 500));
                                Modular.to.popAndPushNamed(
                                  LoginPage.routeName,
                                  arguments: emailController.text,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: Colors.red.shade800,
                                    content: Text(
                                      "Usuário já cadastrado!",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                                await Future.delayed(
                                    Duration(milliseconds: 500));
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
                                "Cadastrar",
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
                        Modular.to.popAndPushNamed(LoginPage.routeName),
                    child: Column(
                      children: [
                        Text(
                          "Já possui uma conta?",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Login",
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
