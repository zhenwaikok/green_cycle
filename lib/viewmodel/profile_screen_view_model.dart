import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class ProfileScreenViewModel extends BaseViewModel {
  ProfileScreenViewModel({required this.userRepository});

  final UserRepository userRepository;

  UserModel? _userDetails;
  UserModel? get userDetails => _userDetails;

  Future<void> getUserDetails({
    required String userID,
    bool? noNeedUpdateUserSharedPreference,
  }) async {
    final response = await userRepository.getUserDetails(
      userID: userID,
      noNeedUpdateUserSharedPreference: noNeedUpdateUserSharedPreference,
    );

    if (response.data is UserModel) {
      _userDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }
}
