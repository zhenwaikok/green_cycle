import 'dart:convert';

import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHandler {
  static final SharedPreferenceHandler _instance =
      SharedPreferenceHandler._internal();
  static SharedPreferences? _sharedPreferences;

  static const spUser = 'user';
  static const spHasOnboarded = 'hasOnboarded';

  /// Factory constructor that returns the single instance.
  factory SharedPreferenceHandler() {
    return _instance;
  }

  SharedPreferenceHandler._internal();

  Future<void> initialize() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  //User
  Future<bool?> putUser(UserModel user) async {
    return _sharedPreferences?.setString(spUser, jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final userInfo = _sharedPreferences?.getString(spUser) ?? '';
    if (userInfo.isNotEmpty) {
      final userMap = jsonDecode(userInfo) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    }

    return null;
  }

  //Has Onboarded
  Future<bool?> putHasOnboarded(bool hasOnboarded) async {
    return _sharedPreferences?.setBool(spHasOnboarded, hasOnboarded);
  }

  bool? getHasOnboarded() {
    return _sharedPreferences?.getBool(spHasOnboarded) ?? false;
  }
}
