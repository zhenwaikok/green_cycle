import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/reward_redemption/reward_redemption_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/reward_redemption_services.dart';

class RewardRedemptionRepository {
  RewardRedemptionServices get _rewardRedemptionServices =>
      RewardRedemptionServices();

  Future<MyResponse> getAllRewardRedemptions() async {
    final response = await _rewardRedemptionServices.getAllRewardRedemptions();

    if (response.data is Map<String, dynamic>) {
      final resultModel = RewardRedemptionModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertRewardRedemption({
    required RewardRedemptionModel rewardRedemptionModel,
  }) async {
    final response = await _rewardRedemptionServices.insertRewardRedemption(
      rewardRedemptionModel: rewardRedemptionModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = RewardRedemptionModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getRewardRedemptionsWithUserID({
    required String userID,
  }) async {
    final response = await _rewardRedemptionServices
        .getRewardRedemptionsWithUserID(userID: userID);

    if (response.data is List) {
      final resultModel = (response.data as List)
          .map((json) => RewardRedemptionModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getRewardRedemptionDetails({
    required int rewardRedemptionID,
  }) async {
    final response = await _rewardRedemptionServices.getRewardRedemptionDetails(
      rewardRedemptionID: rewardRedemptionID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = RewardRedemptionModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateRewardRedemption({
    required int rewardRedemptionID,
    required RewardRedemptionModel rewardRedemptionModel,
  }) async {
    final response = await _rewardRedemptionServices.updateRewardRedemption(
      rewardRedemptionID: rewardRedemptionID,
      rewardRedemptionModel: rewardRedemptionModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ApiResponseModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteRewardRedemption({
    required int rewardRedemptionID,
  }) async {
    final response = await _rewardRedemptionServices.deleteRewardRedemption(
      rewardRedemptionID: rewardRedemptionID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = RewardRedemptionModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
