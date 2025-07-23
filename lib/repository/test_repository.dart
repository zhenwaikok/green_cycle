import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/model/test_model.dart';
import 'package:green_cycle_fyp/services/test_services.dart';

class TestRepository {
  Future<MyResponse> getDogImage() async {
    final response = await TestServices().testAPICall();

    if (response.data is Map<String, dynamic>) {
      final resultModel = DogImageResponse.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
