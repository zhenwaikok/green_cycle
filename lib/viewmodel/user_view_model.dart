import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  UserViewModel({
    required this.userRepository,
    required this.firebaseRepository,
  });

  final UserRepository userRepository;
  final FirebaseRepository firebaseRepository;

  bool get isLoggedIn => userRepository.isLoggedIn;
  UserModel? get user => userRepository.user;

  UserModel? _userDetails;
  List<UserModel> _userList = [];
  UserModel? get userDetails => _userDetails;
  List<UserModel> get userList => _userList;

  Future<bool> signUpWithEmailPassword({
    required String email,
    required String password,
    required String userRole,
    String? firstName,
    String? lastName,
    String? fullName,
    required String gender,
    required String phoneNumber,
    String? address1,
    String? address2,
    String? city,
    String? postalCode,
    String? state,
    String? vehicleType,
    String? vehiclePlateNumber,
    String? companyName,
    String? accountRejectMessage,
    File? profileImage,
  }) async {
    bool isCollectorSignUp = userRole == DropDownItems.roles[1];
    UserModel userModel;

    final response = await userRepository.signUpWithEmailPassword(
      email: email,
      password: password,
    );

    if (response.data is User) {
      String? imageURL;
      if (profileImage != null) {
        final response = await uploadImage(
          storageRef: 'ProfileImages',
          image: profileImage,
        );

        imageURL = response;
      }
      User user = response.data;

      userModel = UserModel(
        userID: user.uid,
        userRole: userRole,
        fullName: fullName,
        firstName: firstName,
        lastName: lastName,
        emailAddress: email,
        gender: gender,
        phoneNumber: phoneNumber,
        password: password,
        address1: address1,
        address2: address2,
        city: city,
        postalCode: postalCode,
        state: state,
        vehicleType: vehicleType,
        vehiclePlateNumber: vehiclePlateNumber,
        companyName: companyName,
        profileImageURL: imageURL,
        approvalStatus: isCollectorSignUp ? 'Pending' : null,
        accountRejectMessage: accountRejectMessage,
        currentPoint: isCollectorSignUp ? null : 0,
        createdDate: DateTime.now(),
      );

      final result = await insertUser(userModel: userModel);
      checkError(response);
      return result;
    }

    checkError(response);
    return false;
  }

  Future<UserModel?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await userRepository.loginWithEmailPassword(
      email: email,
      password: password,
    );

    if (response.data is User) {
      await getUserDetails(userID: response.data.uid);
      return _userDetails;
    }

    checkError(response);
    return null;
  }

  Future<bool> logout() async {
    final response = await userRepository.logout();

    checkError(response);
    return response.data;
  }

  Future<bool> insertUser({required UserModel userModel}) async {
    final response = await userRepository.insertUser(userModel: userModel);
    checkError(response);
    return response.data is UserModel;
  }

  Future<void> getAllUsers() async {
    final response = await userRepository.getAllUsers();

    if (response.data is List<UserModel>) {
      _userList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

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

  Future<bool> updateUser({
    String? userID,
    String? emailAddress,
    String? password,
    String? userRole,
    String? firstName,
    String? lastName,
    String? fullName,
    String? gender,
    String? phoneNumber,
    String? address1,
    String? address2,
    String? city,
    String? postalCode,
    String? state,
    String? vehicleType,
    String? vehiclePlateNumber,
    String? companyName,
    String? approvalStatus,
    String? accountRejectMessage,
    int? point,
    bool? isAddPoint,
    DateTime? createdDate,
    String? profileImageURL,
    File? profileImage,
    bool? noNeedUpdateUserSharedPreference,
  }) async {
    String? imageURL;
    if (profileImage != null) {
      final response = await uploadImage(
        storageRef: 'ProfileImages',
        image: profileImage,
      );

      imageURL = response;
    }

    String? newProfileImageURL = imageURL ?? profileImageURL;
    final newCurrentPoint = isAddPoint == true
        ? (point ?? 0) + (_userDetails?.currentPoint ?? 0)
        : (_userDetails?.currentPoint ?? 0) - (point ?? 0);
    UserModel usermodel = UserModel();

    if (noNeedUpdateUserSharedPreference == true) {
      usermodel = UserModel(
        userID: userID ?? _userDetails?.userID,
        userRole: _userDetails?.userRole,
        fullName: _userDetails?.fullName,
        firstName: _userDetails?.firstName,
        lastName: _userDetails?.lastName,
        emailAddress: _userDetails?.emailAddress,
        gender: _userDetails?.gender,
        phoneNumber: _userDetails?.phoneNumber,
        password: _userDetails?.password,
        address1: _userDetails?.address1,
        address2: _userDetails?.address2,
        city: _userDetails?.city,
        postalCode: _userDetails?.postalCode,
        state: _userDetails?.state,
        vehicleType: _userDetails?.vehicleType,
        vehiclePlateNumber: _userDetails?.vehiclePlateNumber,
        companyName: _userDetails?.companyName,
        profileImageURL: _userDetails?.profileImageURL,
        approvalStatus: approvalStatus ?? _userDetails?.approvalStatus,
        accountRejectMessage:
            accountRejectMessage ?? _userDetails?.accountRejectMessage,
        currentPoint: point != null
            ? newCurrentPoint
            : _userDetails?.currentPoint,
        createdDate: _userDetails?.createdDate ?? DateTime.now(),
      );
    } else {
      usermodel = UserModel(
        userID: userID,
        userRole: userRole,
        fullName: fullName,
        firstName: firstName,
        lastName: lastName,
        emailAddress: emailAddress,
        gender: gender,
        phoneNumber: phoneNumber,
        password: password,
        address1: address1,
        address2: address2,
        city: city,
        postalCode: postalCode,
        state: state,
        vehicleType: vehicleType,
        vehiclePlateNumber: vehiclePlateNumber,
        companyName: companyName,
        profileImageURL: newProfileImageURL,
        approvalStatus: approvalStatus,
        accountRejectMessage: accountRejectMessage,
        currentPoint: point,
        createdDate: createdDate ?? DateTime.now(),
      );
    }

    final response = await userRepository.updateUser(
      userID: userID ?? '',
      userModel: usermodel,
      noNeedUpdateUserSharedPreference:
          noNeedUpdateUserSharedPreference ?? false,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }

  Future<String> uploadImage({
    required String storageRef,
    File? image,
    List<File>? images,
  }) async {
    final response = await firebaseRepository.uploadPhoto(
      storageRef: storageRef,
      image: image,
      images: images,
    );

    checkError(response);
    return response.data;
  }

  Future<bool> updateAccountPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final updatePasswordResponse = await userRepository.updateAccountPassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    checkError(updatePasswordResponse);

    if (updatePasswordResponse.data) {
      final updateUserResponse = await updateUser(
        userID: user?.userID,
        emailAddress: user?.emailAddress,
        password: newPassword,
        userRole: user?.userRole,
        firstName: user?.firstName,
        lastName: user?.lastName,
        fullName: user?.fullName,
        gender: user?.gender,
        phoneNumber: user?.phoneNumber,
        address1: user?.address1,
        address2: user?.address2,
        city: user?.city,
        postalCode: user?.postalCode,
        state: user?.state,
        vehicleType: user?.vehicleType,
        vehiclePlateNumber: user?.vehiclePlateNumber,
        companyName: user?.companyName,
        profileImageURL: user?.profileImageURL,
        accountRejectMessage: user?.accountRejectMessage,
        approvalStatus: user?.approvalStatus,
        createdDate: user?.createdDate,
      );

      return updateUserResponse;
    }

    return false;
  }
}
