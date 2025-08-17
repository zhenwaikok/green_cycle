import 'dart:io';

import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class RewardViewModel extends BaseViewModel {
  RewardViewModel({
    required this.rewardRepository,
    required this.firebaseRepository,
  });

  final RewardRepository rewardRepository;
  final FirebaseRepository firebaseRepository;

  Future<List<RewardModel>> getRewardList() async {
    final response = await rewardRepository.getAllRewards();
    if (response.data is List<RewardModel>) {
      final rewardList = response.data;
      return rewardList;
    }

    checkError(response);
    return [];
  }

  Future<RewardModel> getRewardDetails({required int rewardID}) async {
    final response = await rewardRepository.getRewardDetails(
      rewardID: rewardID,
    );
    if (response.data is RewardModel) {
      final rewardDetails = response.data;
      return rewardDetails;
    }

    checkError(response);
    return RewardModel();
  }

  Future<bool> insertReward({
    required String rewardName,
    required String rewardDescription,
    required int pointsRequired,
    required File? rewardImage,
    required DateTime expiryDate,
  }) async {
    String? imageURL;
    final uploadImageResponse = await uploadImage(
      storageRef: 'RewardImages',
      image: rewardImage,
    );
    imageURL = uploadImageResponse;

    RewardModel rewardModel = RewardModel(
      rewardName: rewardName,
      rewardDescription: rewardDescription,
      pointsRequired: pointsRequired,
      rewardImageURL: imageURL,
      createdDate: DateTime.now(),
      expiryDate: expiryDate,
      isActive: true,
    );

    final insertRewardResponse = await rewardRepository.insertReward(
      rewardModel: rewardModel,
    );

    checkError(insertRewardResponse);
    return insertRewardResponse.data is RewardModel;
  }

  Future<bool> updateReward({
    required int rewardID,
    required String rewardName,
    required String rewardDescription,
    required int pointsRequired,
    required String rewardImageURL,
    required DateTime createdDate,
    required DateTime expiryDate,
    required bool isActive,
    File? rewardImage,
  }) async {
    String? imageURL;
    if (rewardImage != null) {
      final uploadImageResponse = await uploadImage(
        storageRef: 'RewardImages',
        image: rewardImage,
      );
      imageURL = uploadImageResponse;
    }

    String newImageURL = imageURL ?? rewardImageURL;

    RewardModel rewardModel = RewardModel(
      rewardID: rewardID,
      rewardName: rewardName,
      rewardDescription: rewardDescription,
      pointsRequired: pointsRequired,
      rewardImageURL: newImageURL,
      createdDate: createdDate,
      expiryDate: expiryDate,
      isActive: isActive,
    );

    final updateRewardResponse = await rewardRepository.updateReward(
      rewardID: rewardID,
      rewardModel: rewardModel,
    );

    checkError(updateRewardResponse);
    return updateRewardResponse.data is ApiResponseModel;
  }

  Future<bool> deleteReward({required int rewardID}) async {
    final response = await rewardRepository.deleteReward(rewardID: rewardID);
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
