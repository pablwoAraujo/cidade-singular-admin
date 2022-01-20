class User {
  String id;
  String email;
  String name;
  String description;
  String type;
  String picture;
  User({
    required this.id,
    required this.email,
    required this.name,
    this.description = "",
    this.type = "VISITOR",
    this.picture = "",
  });

  User.fromMap(Map map)
      : id = map["id"],
        email = map["email"],
        name = map["name"],
        description = map["description"],
        type = map["type"],
        picture = map["picture"];
}
