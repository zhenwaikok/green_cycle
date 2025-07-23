import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/base_services.dart';

class PickupRequestServices extends BaseServices {
  Future<MyResponse> getAllPickupRequests() async {
    String path = '${apiUrl()}/PickupRequest';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertPickupRequest({
    required PickupRequestModel pickupRequestModel,
  }) async {
    String path = '${apiUrl()}/PickupRequest';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: pickupRequestModel.toJson(),
    );
  }

  Future<MyResponse> getPickupRequestsWithUserID({
    required String userID,
  }) async {
    String path = '${apiUrl()}/PickupRequest/User/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> getPickupRequestDetails({
    required String requestID,
  }) async {
    String path = '${apiUrl()}/PickupRequest/$requestID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updatePickupRequest({
    required String requestID,
    required PickupRequestModel pickupRequestModel,
  }) async {
    String path = '${apiUrl()}/PickupRequest/$requestID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: pickupRequestModel.toJson(),
    );
  }

  Future<MyResponse> deletePickupRequest({required String requestID}) async {
    String path = '${apiUrl()}/PickupRequest/$requestID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
