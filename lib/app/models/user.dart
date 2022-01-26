import 'package:cidade_singular_admin/app/models/city.dart';

class User {
  String id;
  String email;
  String name;
  String description;
  String type;
  String picture;
  City? city;
  User({
    required this.id,
    required this.email,
    required this.name,
    this.city,
    this.description = "",
    this.type = "VISITOR",
    this.picture = "",
  });

  User.fromMap(Map map)
      : id = map["_id"],
        email = map["email"],
        name = map["name"],
        description = map["description"],
        type = map["type"],
        picture = map["picture"],
        city = map["city"] == null ? null : City.fromMap(map["city"]);
}
