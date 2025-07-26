import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class TestServices extends BaseServices {
  Future<MyResponse> testAPICall() async {
    String path = 'https://dog.ceo/api/breeds/image/random';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }
}
