import 'dart:io';

import 'package:dio/dio.dart';

class Suggestion {
  final String placeId;
  final String description;
  double? lat;
  double? lng;

  Suggestion(this.placeId, this.description, {this.lat, this.lng});

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId), lat: $lat, lon: $lng';
  }
}

class PlaceApiProvider {
  final Dio dio = Dio();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static const String apiKey = 'AIzaSyACtmxnxRymLJh3rhS0wkAaFsFgDNzXLDk';

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&components=country:br&key=$apiKey&sessiontoken=$sessionToken';

    final response = await dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Suggestion> getPlaceDetail(Suggestion place) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=${place.placeId}&key=$apiKey&sessiontoken=$sessionToken';
    final response = await dio.get(request);

    if (response.statusCode == 200) {
      final result = response.data;
      if (result['status'] == 'OK') {
        place.lat = result['result']['geometry']['location']['lat'];
        place.lng = result['result']['geometry']['location']['lng'];
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
