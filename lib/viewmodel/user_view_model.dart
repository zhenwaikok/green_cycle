import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/model/error/error_model.dart';
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
    String? address,
    String? vehicleType,
    String? vehiclePlateNumber,
    String? companyName,
    String? accountRejectMessage,
    File? profileImage,
  }) async {
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
        address: address,
        vehicleType: vehicleType,
        vehiclePlateNumber: vehiclePlateNumber,
        companyName: companyName,
        profileImageURL: imageURL,
        approvalStatus: 'Pending',
        accountRejectMessage: accountRejectMessage,
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
    bool? isApproveCollectorAccount,
  }) async {
    final response = await userRepository.getUserDetails(
      userID: userID,
      isApproveCollectorAccount: isApproveCollectorAccount,
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
    String? address,
    String? vehicleType,
    String? vehiclePlateNumber,
    String? companyName,
    String? approvalStatus,
    String? accountRejectMessage,
    DateTime? createdDate,
    String? profileImageURL,
    File? profileImage,
    bool? isApproveCollectorAccount,
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
    UserModel usermodel = UserModel();

    if (isApproveCollectorAccount == true) {
      usermodel = UserModel(
        userID: userDetails?.userID,
        userRole: userDetails?.userRole,
        fullName: userDetails?.fullName,
        firstName: userDetails?.firstName,
        lastName: userDetails?.lastName,
        emailAddress: userDetails?.emailAddress,
        gender: userDetails?.gender,
        phoneNumber: userDetails?.phoneNumber,
        password: userDetails?.password,
        address: userDetails?.address,
        vehicleType: userDetails?.vehicleType,
        vehiclePlateNumber: userDetails?.vehiclePlateNumber,
        companyName: userDetails?.companyName,
        profileImageURL: userDetails?.profileImageURL,
        approvalStatus: approvalStatus,
        accountRejectMessage:
            accountRejectMessage ?? userDetails?.accountRejectMessage,
        createdDate: userDetails?.createdDate ?? DateTime.now(),
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
        address: address,
        vehicleType: vehicleType,
        vehiclePlateNumber: vehiclePlateNumber,
        companyName: companyName,
        profileImageURL: newProfileImageURL,
        approvalStatus: approvalStatus,
        accountRejectMessage: accountRejectMessage,
        createdDate: createdDate ?? DateTime.now(),
      );
    }

    final response = await userRepository.updateUser(
      userID: userID ?? '',
      userModel: usermodel,
      isApproveCollectorAccount: isApproveCollectorAccount ?? false,
    );

    checkError(response);
    return response.data is ErrorModel;
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
        address: user?.address,
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
