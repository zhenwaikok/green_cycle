import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';

part 'reward_redemption_model.freezed.dart';
part 'reward_redemption_model.g.dart';

@freezed
class RewardRedemptionModel with _$RewardRedemptionModel {
  const factory RewardRedemptionModel({
    int? rewardRedemptionID,
    String? userID,
    int? rewardID,
    bool? isUsed,
    DateTime? redeemedDate,
    RewardModel? reward,
  }) = _RewardRedemptionModel;

  factory RewardRedemptionModel.fromJson(Map<String, dynamic> json) =>
      _$RewardRedemptionModelFromJson(json);
}
