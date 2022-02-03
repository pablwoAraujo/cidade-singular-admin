import 'package:flutter/material.dart';

class Constants {
  static const Color primaryColor = Color(0xFF28276B);
  static const Color disableColor = Color(0xFF898A96);
  static const Color grey = Color(0xFFE5E5E5);

  static const Color MUSIC = Color(0xFFF3D59B);
  static const Color ARTS = Color(0xFF8588DD);
  static const Color GASTRONOMY = Color(0xFFB4EAC0);
  static const Color DESIGN = Color(0xFFFE95F3);
  static const Color CRAFTS = Color(0xFFF8C18E);
  static const Color LITERATURE = Color(0xFFB0DCF4);
  static const Color FILM = Color(0xFFD29BF3);

  static Color getColor(String area) {
    switch (area) {
      case "MUSIC":
        return MUSIC;
      case "ARTS":
        return ARTS;
      case "GASTRONOMY":
        return GASTRONOMY;
      case "CRAFTS":
        return CRAFTS;
      case "DESIGN":
        return DESIGN;
      case "LITERATURE":
        return LITERATURE;
      case "FILM":
        return FILM;
      default:
        return grey;
    }
  }
}
