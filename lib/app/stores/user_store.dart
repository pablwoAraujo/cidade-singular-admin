import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/services/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  User? user;

  @action
  setUser(User? newUser) async {
    user = newUser;
  }
}
