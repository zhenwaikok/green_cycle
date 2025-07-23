import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/reward_redemption/reward_redemption_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/base_services.dart';

class RewardRedemptionServices extends BaseServices {
  Future<MyResponse> getAllRewardRedemptions() async {
    String path = '${apiUrl()}/RewardRedemption';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertRewardRedemption({
    required RewardRedemptionModel rewardRedemptionModel,
  }) async {
    String path = '${apiUrl()}/RewardRedemption';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: rewardRedemptionModel.toJson(),
    );
  }

  Future<MyResponse> getRewardRedemptionsWithUserID({
    required String userID,
  }) async {
    String path = '${apiUrl()}/RewardRedemption/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getRewardRedemptionDetails({
    required int rewardRedemptionID,
  }) async {
    String path = '${apiUrl()}/RewardRedemption/$rewardRedemptionID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updateRewardRedemption({
    required int rewardRedemptionID,
    required RewardRedemptionModel rewardRedemptionModel,
  }) async {
    String path = '${apiUrl()}/RewardRedemption/$rewardRedemptionID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: rewardRedemptionModel.toJson(),
    );
  }

  Future<MyResponse> deleteRewardRedemption({
    required int rewardRedemptionID,
  }) async {
    String path = '${apiUrl()}/RewardRedemption/$rewardRedemptionID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
