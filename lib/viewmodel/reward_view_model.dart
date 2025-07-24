import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class RewardViewModel extends BaseViewModel {
  RewardViewModel({required this.rewardRepository});

  final RewardRepository rewardRepository;

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
}
