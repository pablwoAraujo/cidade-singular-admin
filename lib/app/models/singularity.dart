class Singularity {
  String id;
  String visitingHours;
  String title;
  String description;
  String address;
  String type;
  List<String> photos;

  Singularity({
    required this.id,
    required this.address,
    required this.description,
    required this.title,
    required this.type,
    required this.visitingHours,
    required this.photos,
  });

  Singularity.fromMap(map)
      : id = map["_id"],
        visitingHours = map["visitingHours"],
        title = map["title"],
        description = map["description"],
        address = map["address"],
        type = map["type"],
        photos = List<String>.from(map["photos"]);
}
