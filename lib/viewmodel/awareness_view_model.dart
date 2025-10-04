import 'dart:io';

import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class AwarenessViewModel extends BaseViewModel {
  AwarenessViewModel({
    required this.awarenessRepository,
    required this.firebaseRepository,
  });
  final AwarenessRepository awarenessRepository;
  final FirebaseRepository firebaseRepository;

  AwarenessModel? _awarenessDetails;
  AwarenessModel? get awarenessDetails => _awarenessDetails;

  Future<List<AwarenessModel>> getAwarenessList() async {
    final response = await awarenessRepository.getAllAwareness();

    if (response.data is List<AwarenessModel>) {
      final awarenessList = response.data as List<AwarenessModel>;
      return awarenessList;
    }

    checkError(response);
    return [];
  }

  Future<void> getAwarenessDetails({required int awarenessID}) async {
    final response = await awarenessRepository.getAwarenessDetails(
      awarenessID: awarenessID,
    );
    if (response.data is AwarenessModel) {
      _awarenessDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> addAwareness({
    required String awarenessTitle,
    required String awarenessContent,
    required File? image,
  }) async {
    String? imageURL;
    final uploadImageResponse = await uploadImage(
      storageRef: 'AwarenessImages',
      image: image,
    );
    imageURL = uploadImageResponse;

    AwarenessModel awarenessModel = AwarenessModel(
      awarenessTitle: awarenessTitle,
      awarenessContent: awarenessContent,
      awarenessImageURL: imageURL,
      createdDate: DateTime.now(),
    );

    final response = await awarenessRepository.insertAwareness(
      awarenessModel: awarenessModel,
    );

    checkError(response);
    return response.data is AwarenessModel;
  }

  Future<bool> updateAwareness({
    required int awarenessID,
    required String awarenessTitle,
    required String awarenessContent,
    File? awarenessImage,
  }) async {
    String? imageURL;
    if (awarenessImage != null) {
      final response = await uploadImage(
        storageRef: 'AwarenessImages',
        image: awarenessImage,
      );

      imageURL = response;
    }

    String? newAwarenessImageURL =
        imageURL ?? _awarenessDetails?.awarenessImageURL;

    AwarenessModel awarenessModel = AwarenessModel(
      awarenessID: awarenessID,
      awarenessTitle: awarenessTitle,
      awarenessContent: awarenessContent,
      awarenessImageURL: newAwarenessImageURL,
      createdDate: _awarenessDetails?.createdDate,
    );

    final response = await awarenessRepository.updateAwareness(
      awarenessID: awarenessID,
      awarenessModel: awarenessModel,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }

  Future<bool> deleteAwareness({required int awarenessID}) async {
    final response = await awarenessRepository.deleteAwareness(
      awarenessID: awarenessID,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }

  Future<String> uploadImage({
    required String storageRef,
    File? image,
    List<File>? images,
  }) async {
    final response = await firebaseRepository.uploadPhoto(
      storageRef: storageRef,
      image: image,
      images: images,
    );

    checkError(response);
    return response.data;
  }
}
