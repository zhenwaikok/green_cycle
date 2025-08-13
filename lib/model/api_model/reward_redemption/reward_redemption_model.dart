import 'package:freezed_annotation/freezed_annotation.dart';
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
    String? rewardName,
    String? rewardDescription,
    int? pointsRequired,
    String? rewardImageURL,
    DateTime? expiryDate,
  }) = _RewardRedemptionModel;

  factory RewardRedemptionModel.fromJson(Map<String, dynamic> json) =>
      _$RewardRedemptionModelFromJson(json);
}
