import 'package:cidade_singular_admin/app/services/user_service.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecoveryDialog extends StatefulWidget {
  final String email;
  const RecoveryDialog({Key? key, required this.email}) : super(key: key);

  @override
  _RecoveryDialogState createState() => _RecoveryDialogState();
}

class _RecoveryDialogState extends State<RecoveryDialog> {
  bool emailSent = false;
  bool loading = false;

  UserService userService = Modular.get();

  bool request = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enviar email de recuperação de senha para ${widget.email}?"),
      content: loading
          ? Center(
              heightFactor: 1,
              child: CircularProgressIndicator(),
            )
          : !request
              ? SizedBox()
              : Text(
                  emailSent
                      ? "Uma nova senha foi enviada para seu email"
                      : "Não foi possível recuperar a senha, verifique seu email e tente novamente mais tarde",
                  style: TextStyle(
                    color:
                        emailSent ? Constants.primaryColor : Colors.redAccent,
                  ),
                ),
      actions: request
          ? [
              TextButton(
                onPressed: () {
                  Modular.to.pop(false);
                },
                child: Text("Voltar"),
              )
            ]
          : [
              TextButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                    request = true;
                  });
                  bool sent = await userService.recovery(email: widget.email);

                  setState(() {
                    emailSent = sent;
                    loading = false;
                  });
                },
                child: Text(
                  "Enviar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Modular.to.pop(false);
                },
                child: Text("Cancelar"),
              )
            ],
    );
  }
}
