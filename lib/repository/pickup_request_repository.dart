import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/pickup_request_services.dart';

class PickupRequestRepository {
  PickupRequestServices get _pickupRequestServices => PickupRequestServices();

  Future<MyResponse> getAllPickupRequests() async {
    final response = await _pickupRequestServices.getAllPickupRequests();

    if (response.data is Map<String, dynamic>) {
      final resultModel = PickupRequestModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertPickupRequest({
    required PickupRequestModel pickupRequestModel,
  }) async {
    final response = await _pickupRequestServices.insertPickupRequest(
      pickupRequestModel: pickupRequestModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PickupRequestModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPickupRequestsWithUserID({
    required String userID,
  }) async {
    final response = await _pickupRequestServices.getPickupRequestsWithUserID(
      userID: userID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PickupRequestModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getPickupRequestDetails({
    required String requestID,
  }) async {
    final response = await _pickupRequestServices.getPickupRequestDetails(
      requestID: requestID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PickupRequestModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updatePickupRequest({
    required String requestID,
    required PickupRequestModel pickupRequestModel,
  }) async {
    final response = await _pickupRequestServices.updatePickupRequest(
      requestID: requestID,
      pickupRequestModel: pickupRequestModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PickupRequestModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deletePickupRequest({required String requestID}) async {
    final response = await _pickupRequestServices.deletePickupRequest(
      requestID: requestID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = PickupRequestModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
