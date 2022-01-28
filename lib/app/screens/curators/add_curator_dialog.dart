import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/services/user_service.dart';
import 'package:cidade_singular_admin/app/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddCuratorDialog extends StatefulWidget {
  const AddCuratorDialog({Key? key}) : super(key: key);

  @override
  _AddCuratorPageState createState() => _AddCuratorPageState();
}

class _AddCuratorPageState extends State<AddCuratorDialog> {
  bool loading = false;
  List<User> users = [];

  UserService service = Modular.get();
  UserStore userStore = Modular.get();

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() async {
    setState(() => loading = true);
    users = await service.getUsers(query: {
      "type": UserType.VISITOR.toString().split(".").last,
    });
    setState(() => loading = false);
  }

  Future<void> addCurator(User curator) async {
    User? newCurator = await service.update(
      id: curator.id,
      city: userStore.user?.city?.id,
      type: UserType.CURATOR.toString().split(".").last,
      curator_type: userStore.user?.curator_type.toString().split(".").last,
    );
    if (newCurator != null) {
      Modular.to.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Adicionar curador"),
      actions: [
        TextButton(
          onPressed: () => Modular.to.pop(true),
          child: Text("Cancelar"),
        )
      ],
      scrollable: false,
      contentPadding: EdgeInsets.all(0),
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      content: loading
          ? SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                  children: users
                      .map(
                        (user) => ListTile(
                          onTap: () async => await addCurator(user),
                          leading: CircleAvatar(
                            foregroundImage: NetworkImage(user.picture),
                            onForegroundImageError: (_, __) {},
                            child: Text(
                              user.name[0],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                        ),
                      )
                      .toList()),
            ),
    );
  }
}
