import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/reward_services.dart';

class RewardRepository {
  RewardServices get _rewardServices => RewardServices();

  Future<MyResponse> getAllRewards() async {
    final response = await _rewardServices.getAllRewards();

    if (response.data is List) {
      final resultList = (response.data as List)
          .map((json) => RewardModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultList);
    }
    return response;
  }

  Future<MyResponse> insertReward({required RewardModel rewardModel}) async {
    final response = await _rewardServices.insertReward(
      rewardModel: rewardModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = RewardModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getRewardDetails({required int rewardID}) async {
    final response = await _rewardServices.getRewardDetails(rewardID: rewardID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = RewardModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateReward({
    required int rewardID,
    required RewardModel rewardModel,
  }) async {
    final response = await _rewardServices.updateReward(
      rewardID: rewardID,
      rewardModel: rewardModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ApiResponseModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteReward({required int rewardID}) async {
    final response = await _rewardServices.deleteReward(rewardID: rewardID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = RewardModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
