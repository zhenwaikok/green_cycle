import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/model/auth_request_model/auth_request_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';
import 'package:green_cycle_fyp/services/firebase_base_services.dart';

class UserServices extends BaseServices with FirebaseBaseServices {
  Future<MyResponse> signUpWithEmailPassword({
    required AuthRequestModel authRequestModel,
  }) {
    return authenticate(
      authType: AuthType.signUp,
      requestBody: authRequestModel.toJson(),
    );
  }

  Future<MyResponse> loginWithEmailPassword({
    required AuthRequestModel authRequestModel,
  }) {
    return authenticate(
      authType: AuthType.login,
      requestBody: authRequestModel.toJson(),
    );
  }

  Future<MyResponse> logout() {
    return authenticate(authType: AuthType.logout);
  }

  Future<MyResponse> getAllUsers() async {
    String path = '${apiUrl()}/User';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertUser({required UserModel userModel}) async {
    String path = '${apiUrl()}/User';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: userModel.toJson(),
    );
  }

  Future<MyResponse> getUserDetails({required String userID}) async {
    String path = '${apiUrl()}/User/$userID';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updateUser({
    required String userID,
    required UserModel userModel,
  }) async {
    String path = '${apiUrl()}/User/$userID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: userModel.toJson(),
    );
  }

  Future<MyResponse> deleteUser({required String userID}) async {
    String path = '${apiUrl()}/User/$userID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }

  Future<MyResponse> updateAccountPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return updatePassword(oldPassword: oldPassword, newPassword: newPassword);
  }
}
