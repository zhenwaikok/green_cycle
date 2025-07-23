import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';

class AwarenessRepository {
  AwarenessServices get _awarenessServices => AwarenessServices();

  Future<MyResponse> getAllAwareness() async {
    final response = await _awarenessServices.getAllAwareness();

    if (response.data is Map<String, dynamic>) {
      final resultModel = AwarenessModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertAwareness({
    required AwarenessModel awarenessModel,
  }) async {
    final response = await _awarenessServices.insertAwareness(
      awarenessModel: awarenessModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = AwarenessModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getAwarenessDetails({required int awarenessID}) async {
    final response = await _awarenessServices.getAwarenessDetails(
      awarenessID: awarenessID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = AwarenessModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateAwareness({
    required int awarenessID,
    required AwarenessModel awarenessModel,
  }) async {
    final response = await _awarenessServices.updateAwareness(
      awarenessID: awarenessID,
      awarenessModel: awarenessModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = AwarenessModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteAwareness({required int awarenessID}) async {
    final response = await _awarenessServices.deleteAwareness(
      awarenessID: awarenessID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = AwarenessModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
