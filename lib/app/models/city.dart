class City {
  String id;
  String title;
  String blazon;
  String subtitle;
  String description;
  List<String> pictures;

  City({
    required this.id,
    required this.title,
    required this.blazon,
    required this.subtitle,
    required this.description,
    required this.pictures,
  });

  City.fromMap(map)
      : id = map["_id"],
        title = map["title"],
        blazon = map["blazon"],
        subtitle = map["subtitle"],
        description = map["description"],
        pictures = List<String>.from(map["pictures"]);
}
