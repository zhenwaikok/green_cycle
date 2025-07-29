import 'dart:io';

import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/firebase_base_services.dart';

class FirebaseServices with FirebaseBaseServices {
  Future<MyResponse> uploadPhoto({
    required String storageRef,
    File? image,
    List<File>? images,
  }) async {
    return uploadImage(storageRef: storageRef, image: image, images: images);
  }
}
