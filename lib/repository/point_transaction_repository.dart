import 'package:green_cycle_fyp/model/api_model/points/points_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/points_transaction_services.dart';

class PointTransactionRepository {
  PointTransactionServices get _pointsServices => PointTransactionServices();

  Future<MyResponse> getAllPointTransactions() async {
    final response = await _pointsServices.getAllPointTransactions();

    if (response.data is List) {
      final resultModel = (response.data as List)
          .map((json) => PointsModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertPointTransaction({
    required PointsModel pointsModel,
  }) async {
    final response = await _pointsServices.insertPointTransaction(
      pointsModel: pointsModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPointTransactionsWithUserID({
    required String userID,
  }) async {
    final response = await _pointsServices.getPointTransactionsWithUserID(
      userID: userID,
    );

    if (response.data is List) {
      final resultModel = (response.data as List)
          .map((json) => PointsModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPointTransactionDetails({required int pointID}) async {
    final response = await _pointsServices.getPointTransactionDetails(
      pointID: pointID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updatePointTransaction({
    required int pointID,
    required PointsModel pointsModel,
  }) async {
    final response = await _pointsServices.updatePointTransaction(
      pointID: pointID,
      pointsModel: pointsModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deletePointTransaction({required int pointID}) async {
    final response = await _pointsServices.deletePointTransaction(
      pointID: pointID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PointsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
