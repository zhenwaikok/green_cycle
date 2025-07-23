import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/reward/reward_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/base_services.dart';

class RewardServices extends BaseServices {
  Future<MyResponse> getAllRewards() async {
    String path = '${apiUrl()}/Reward';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertReward({required RewardModel rewardModel}) async {
    String path = '${apiUrl()}/Reward';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: rewardModel.toJson(),
    );
  }

  Future<MyResponse> getRewardDetails({required int rewardID}) async {
    String path = '${apiUrl()}/Reward/$rewardID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updateReward({
    required int rewardID,
    required RewardModel rewardModel,
  }) async {
    String path = '${apiUrl()}/Reward/$rewardID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: rewardModel.toJson(),
    );
  }

  Future<MyResponse> deleteReward({required int rewardID}) async {
    String path = '${apiUrl()}/Reward/$rewardID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
