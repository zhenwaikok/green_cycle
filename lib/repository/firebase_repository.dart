import 'dart:io';

import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';

class FirebaseRepository {
  FirebaseRepository({required this.firebaseServices});
  final FirebaseServices firebaseServices;
  Future<MyResponse> uploadPhoto({
    required String storageRef,
    File? image,
    List<File>? images,
  }) async {
    final response = await firebaseServices.uploadPhoto(
      storageRef: storageRef,
      image: image,
      images: images,
    );
    return response;
  }
}
