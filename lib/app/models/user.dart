import 'package:cidade_singular_admin/app/models/city.dart';

class User {
  String id;
  String email;
  String name;
  String description;
  UserType type;
  CuratorType? curator_type;
  String picture;
  City? city;
  User({
    required this.id,
    required this.email,
    required this.name,
    this.city,
    this.description = "",
    this.type = UserType.VISITOR,
    this.curator_type,
    this.picture = "",
  });

  String get typeV => "";

  User.fromMap(Map map)
      : id = map["_id"],
        email = map["email"],
        name = map["name"],
        description = map["description"],
        type = UserType._from[map["type"]],
        curator_type = map["curator_type"] != null
            ? CuratorType._from[map["curator_type"]]
            : null,
        picture = map["picture"],
        city = map["city"] == null || (map['city'] is String)
            ? null
            : City.fromMap(map["city"]);
}

enum UserType {
  _from,
  ADMIN,
  MANAGER,
  CURATOR,
  VISITOR,
}

extension UserTypeExtension on UserType {
  String get value {
    switch (this) {
      case UserType.ADMIN:
        return "Administrador";
      case UserType.MANAGER:
        return "Ponto focal";
      case UserType.CURATOR:
        return "Curador";
      case UserType.VISITOR:
        return "Visitante";
      default:
        return "Não definido";
    }
  }

  operator [](String key) => (name) {
        switch (name) {
          case 'ADMIN':
            return UserType.ADMIN;
          case 'MANAGER':
            return UserType.MANAGER;
          case 'CURATOR':
            return UserType.CURATOR;
          case 'VISITOR':
            return UserType.VISITOR;
          default:
            return null;
        }
      }(key);
}

enum CuratorType {
  _from,
  ARTS,
  CRAFTS,
  FILM,
  DESIGN,
  GASTRONOMY,
  LITERATURE,
  MUSIC,
}

extension CuratorTypeExtension on CuratorType {
  String get value {
    switch (this) {
      case CuratorType.ARTS:
        return "Artes Midiáticas";
      case CuratorType.CRAFTS:
        return "Artesanato";
      case CuratorType.DESIGN:
        return "Design";
      case CuratorType.FILM:
        return "Cinema";
      case CuratorType.GASTRONOMY:
        return "Gastronomia";
      case CuratorType.LITERATURE:
        return "Literatura";
      case CuratorType.MUSIC:
        return "Música";
      default:
        return "Não definido";
    }
  }

  operator [](String key) => (name) {
        switch (name) {
          case 'ARTS':
            return CuratorType.ARTS;
          case 'CRAFTS':
            return CuratorType.CRAFTS;
          case 'DESIGN':
            return CuratorType.DESIGN;
          case 'FILM':
            return CuratorType.FILM;
          case 'GASTRONOMY':
            return CuratorType.GASTRONOMY;
          case 'LITERATURE':
            return CuratorType.LITERATURE;
          case 'MUSIC':
            return CuratorType.MUSIC;
          default:
            return null;
        }
      }(key);
}
