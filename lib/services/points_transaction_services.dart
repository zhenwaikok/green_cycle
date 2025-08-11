import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/points/points_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class PointTransactionServices extends BaseServices {
  Future<MyResponse> getAllPointTransactions() async {
    String path = '${apiUrl()}/Points';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertPointTransaction({
    required PointsModel pointsModel,
  }) async {
    String path = '${apiUrl()}/Points';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: pointsModel.toJson(),
    );
  }

  Future<MyResponse> getPointTransactionsWithUserID({
    required String userID,
  }) async {
    String path = '${apiUrl()}/Points/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getPointTransactionDetails({required int pointID}) async {
    String path = '${apiUrl()}/Points/$pointID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updatePointTransaction({
    required int pointID,
    required PointsModel pointsModel,
  }) async {
    String path = '${apiUrl()}/Points/$pointID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: pointsModel.toJson(),
    );
  }

  Future<MyResponse> deletePointTransaction({required int pointID}) async {
    String path = '${apiUrl()}/Points/$pointID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
