import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/base_services.dart';

class AwarenessServices extends BaseServices {
  Future<MyResponse> getAllAwareness() async {
    String path = '${apiUrl()}/Awareness';
    print('Calling Awareness API: $path');

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertAwareness({
    required AwarenessModel awarenessModel,
  }) async {
    String path = '${apiUrl()}/Awareness';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: awarenessModel.toJson(),
    );
  }

  Future<MyResponse> getAwarenessDetails({required int awarenessID}) async {
    String path = '${apiUrl()}/Awareness/$awarenessID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updateAwareness({
    required int awarenessID,
    required AwarenessModel awarenessModel,
  }) async {
    String path = '${apiUrl()}/Awareness/$awarenessID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: awarenessModel.toJson(),
    );
  }

  Future<MyResponse> deleteAwareness({required int awarenessID}) async {
    String path = '${apiUrl()}/Awareness/$awarenessID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
