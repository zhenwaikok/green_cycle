import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/model/api_model/reward_redemption/reward_redemption_model.dart';
import 'package:green_cycle_fyp/repository/reward_redemption_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class RewardRedemptionViewModel extends BaseViewModel {
  RewardRedemptionViewModel({required this.rewardRedemptionRepository});

  RewardRedemptionRepository rewardRedemptionRepository;

  List<RewardRedemptionModel> _rewardRedemptionList = [];
  List<RewardRedemptionModel> get rewardRedemptionList => _rewardRedemptionList;

  Future<void> getRewardRedemptionsWithUserID({required String userID}) async {
    final response = await rewardRedemptionRepository
        .getRewardRedemptionsWithUserID(userID: userID);

    if (response.data is List<RewardRedemptionModel>) {
      _rewardRedemptionList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> insertRewardRedemption({
    required String userID,
    required RewardModel reward,
  }) async {
    RewardRedemptionModel rewardRedemptionModel = RewardRedemptionModel(
      userID: userID,
      rewardID: reward.rewardID,
      isUsed: false,
      redeemedDate: DateTime.now(),
      rewardName: reward.rewardName,
      rewardDescription: reward.rewardDescription,
      pointsRequired: reward.pointsRequired,
      rewardImageURL: reward.rewardImageURL,
      expiryDate: reward.expiryDate,
    );

    final response = await rewardRedemptionRepository.insertRewardRedemption(
      rewardRedemptionModel: rewardRedemptionModel,
    );

    checkError(response);
    return response.data is RewardRedemptionModel;
  }

  Future<bool> updateRewardRedemption({
    required String userID,
    required bool isUsed,
    required RewardRedemptionModel rewardRedemptionDetails,
  }) async {
    RewardRedemptionModel rewardRedemptionModel = RewardRedemptionModel(
      rewardRedemptionID: rewardRedemptionDetails.rewardRedemptionID,
      userID: userID,
      rewardID: rewardRedemptionDetails.rewardID,
      isUsed: isUsed,
      redeemedDate: rewardRedemptionDetails.redeemedDate,
      rewardName: rewardRedemptionDetails.rewardName,
      rewardDescription: rewardRedemptionDetails.rewardDescription,
      pointsRequired: rewardRedemptionDetails.pointsRequired,
      rewardImageURL: rewardRedemptionDetails.rewardImageURL,
      expiryDate: rewardRedemptionDetails.expiryDate,
    );

    final response = await rewardRedemptionRepository.updateRewardRedemption(
      rewardRedemptionID: rewardRedemptionDetails.rewardRedemptionID ?? 0,
      rewardRedemptionModel: rewardRedemptionModel,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }
}
