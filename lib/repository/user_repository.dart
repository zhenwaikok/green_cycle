import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/model/auth_request_model/auth_request_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';

class UserRepository {
  UserRepository({
    required this.sharePreferenceHandler,
    required this.userServices,
  });

  final UserServices userServices;
  final SharedPreferenceHandler sharePreferenceHandler;

  bool get isLoggedIn => sharePreferenceHandler.getUser() != null;
  UserModel? get user => sharePreferenceHandler.getUser();

  Future<MyResponse> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final authRequestModel = AuthRequestModel(email: email, password: password);

    final response = await userServices.signUpWithEmailPassword(
      authRequestModel: authRequestModel,
    );
    return response;
  }

  Future<MyResponse> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final authRequestModel = AuthRequestModel(email: email, password: password);

    final response = await userServices.loginWithEmailPassword(
      authRequestModel: authRequestModel,
    );
    return response;
  }

  Future<MyResponse> loginWithGoogle({String? password}) async {
    final response = await userServices.loginWithGoogle(
      authRequestModel: AuthRequestModel(password: password),
    );
    print('response repo: ${response.data}');
    return response;
  }

  Future<MyResponse> logout() async {
    final response = await userServices.logout();
    await sharePreferenceHandler.removeAllSP();
    return response;
  }

  Future<MyResponse> passwordReset({required String email}) async {
    final response = await userServices.passwordReset(email: email);
    return response;
  }

  Future<MyResponse> getAllUsers() async {
    final response = await userServices.getAllUsers();

    if (response.data is List) {
      final resultModel = (response.data as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertUser({required UserModel userModel}) async {
    final response = await userServices.insertUser(userModel: userModel);

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      await sharePreferenceHandler.putUser(resultModel);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getUserDetails({
    required String userID,
    bool? noNeedUpdateUserSharedPreference,
  }) async {
    final response = await userServices.getUserDetails(userID: userID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      if (noNeedUpdateUserSharedPreference == null ||
          noNeedUpdateUserSharedPreference == false) {
        await sharePreferenceHandler.putUser(resultModel);
        sharePreferenceHandler.getUser();
      }
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateUser({
    required String userID,
    required UserModel userModel,
    required bool noNeedUpdateUserSharedPreference,
  }) async {
    final response = await userServices.updateUser(
      userID: userID,
      userModel: userModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ApiResponseModel.fromJson(response.data);
      if (!noNeedUpdateUserSharedPreference) {
        await getUserDetails(userID: userID);
      }
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteUser({required String userID}) async {
    final response = await userServices.deleteUser(userID: userID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateAccountPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await userServices.updateAccountPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    return response;
  }
}
