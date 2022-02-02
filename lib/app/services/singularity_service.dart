import 'dart:convert';

import 'package:cidade_singular_admin/app/models/singularity.dart';
import 'package:cidade_singular_admin/app/services/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class SingularityService {
  DioService dioService;

  SingularityService(this.dioService);

  Future<bool> addSingularity({
    required String title,
    required String description,
    required String address,
    required String type,
    required String visitingHours,
    required List<XFile> photos,
    required double lat,
    required double lng,
  }) async {
    try {
      List<String> photosInBase64 = [];

      for (var photo in photos) {
        photosInBase64.add(base64Encode(await photo.readAsBytes()));
      }

      var response = await dioService.dio.post(
        "/singularity",
        data: {
          "visitingHours": visitingHours,
          "title": title,
          "description": description,
          "address": address,
          "type": type,
          "photos": photosInBase64,
          "lat": lat,
          "lng": lng,
        },
      );

      if (response.data["error"]) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      }
      return false;
    }
  }

  Future<List<Singularity>> getSingularities(
      {Map<String, String> query = const {}}) async {
    try {
      var response = await dioService.dio.get(
        "/singularity",
        queryParameters: query,
      );

      if (response.data["error"]) {
        return [];
      } else {
        List<Singularity> sings = [];
        for (Map data in response.data["data"]) {
          sings.add(Singularity.fromMap(data));
        }
        return sings;
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      } else {
        print(e);
      }
      return [];
    }
  }

  Future<bool> removeSingularity({required String singularity}) async {
    try {
      var response = await dioService.dio.delete("/singularity/$singularity");

      if (response.data["error"]) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      if (e is DioError) {
        print(e);
      }
      return false;
    }
  }
}
