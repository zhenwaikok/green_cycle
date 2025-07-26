import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';

class AwarenessRepository {
  AwarenessRepository({required this.awarenessServices});
  AwarenessServices awarenessServices;

  Future<MyResponse> getAllAwareness() async {
    final response = await awarenessServices.getAllAwareness();
    print('Response from Awareness API: ${response.data}');

    if (response.data is List) {
      final resultList = (response.data as List)
          .map((json) => AwarenessModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultList);
    }
    return response;
  }

  Future<MyResponse> insertAwareness({
    required AwarenessModel awarenessModel,
  }) async {
    final response = await awarenessServices.insertAwareness(
      awarenessModel: awarenessModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = AwarenessModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getAwarenessDetails({required int awarenessID}) async {
    final response = await awarenessServices.getAwarenessDetails(
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
    final response = await awarenessServices.updateAwareness(
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
    final response = await awarenessServices.deleteAwareness(
      awarenessID: awarenessID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = AwarenessModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
