import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class RewardViewModel extends BaseViewModel {
  final _rewardRepository = RewardRepository();
  List<RewardModel> rewardList = [];
  RewardModel? rewardDetails;

  Future<void> getRewardList() async {
    notify(MyResponse.loading());

    try {
      final response = await _rewardRepository.getAllRewards();
      if (response.data is List<RewardModel>) {
        rewardList = response.data;
        notify(MyResponse.complete(rewardList));
      } else if (response.status == ResponseStatus.error) {
        final errorResponse = (response.error);
        notify(MyResponse.error(errorResponse));
      }
    } catch (e) {
      debugPrint('error: $e');
      notify(MyResponse.error(e.toString()));
      rethrow;
    }
  }

  Future<void> getRewardDetails({required int rewardID}) async {
    notify(MyResponse.loading());

    try {
      final response = await _rewardRepository.getRewardDetails(
        rewardID: rewardID,
      );
      if (response.data is RewardModel) {
        rewardDetails = response.data;
        notify(MyResponse.complete(rewardDetails));
      } else if (response.status == ResponseStatus.error) {
        final errorResponse = (response.error);
        notify(MyResponse.error(errorResponse));
      }
    } catch (e) {
      debugPrint('error: $e');
      notify(MyResponse.error(e.toString()));
      rethrow;
    }
  }
}
