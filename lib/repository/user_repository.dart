import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/user_services.dart';

class UserRepository {
  UserServices get _userServices => UserServices();

  Future<MyResponse> getAllUsers() async {
    final response = await _userServices.getAllUsers();

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertUser({required UserModel userModel}) async {
    final response = await _userServices.insertUser(userModel: userModel);

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getUserDetails({required String userID}) async {
    final response = await _userServices.getUserDetails(userID: userID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateUser({
    required String userID,
    required UserModel userModel,
  }) async {
    final response = await _userServices.updateUser(
      userID: userID,
      userModel: userModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteUser({required String userID}) async {
    final response = await _userServices.deleteUser(userID: userID);

    if (response.data is Map<String, dynamic>) {
      final resultModel = UserModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }
}
