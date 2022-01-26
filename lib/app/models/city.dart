class City {
  String id;
  String name;
  String description;
  String picture;

  City({
    required this.id,
    required this.description,
    required this.name,
    required this.picture,
  });

  City.fromMap(map)
      : id = map["_id"],
        description = map["description"],
        name = map["name"],
        picture = map["picture"];
}
