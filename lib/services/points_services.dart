import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/points/points_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/base_services.dart';

class PointsServices extends BaseServices {
  Future<MyResponse> getAllPoints() async {
    String path = '${apiUrl()}/Points';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertPoints({required PointsModel pointsModel}) async {
    String path = '${apiUrl()}/Points';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: pointsModel.toJson(),
    );
  }

  Future<MyResponse> getPointsWithUserID({required String userID}) async {
    String path = '${apiUrl()}/Points/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getPointDetails({required int pointID}) async {
    String path = '${apiUrl()}/Points/$pointID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updatePoint({
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

  Future<MyResponse> deletePoints({required int pointID}) async {
    String path = '${apiUrl()}/Points/$pointID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
