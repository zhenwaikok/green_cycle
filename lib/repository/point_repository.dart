import 'package:green_cycle_fyp/model/api_model/points/points_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/points_services.dart';

class PointRepository {
  PointsServices get _pointsServices => PointsServices();

  Future<MyResponse> getAllPoints() async {
    final response = await _pointsServices.getAllPoints();

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertPoints({required PointsModel pointsModel}) async {
    final response = await _pointsServices.insertPoints(
      pointsModel: pointsModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPointsWithUserID({required String userID}) async {
    final response = await _pointsServices.getPointsWithUserID(userID: userID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPointsDetails({required int pointID}) async {
    final response = await _pointsServices.getPointDetails(pointID: pointID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updatePoints({
    required int pointID,
    required PointsModel pointsModel,
  }) async {
    final response = await _pointsServices.updatePoint(
      pointID: pointID,
      pointsModel: pointsModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deletePoints({required int pointID}) async {
    final response = await _pointsServices.deletePoints(pointID: pointID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
