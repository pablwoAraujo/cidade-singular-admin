import 'dart:convert';

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
}
