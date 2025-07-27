import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/model/error/error_model.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  UserViewModel({required this.userRepository});

  final UserRepository userRepository;

  bool get isLoggedIn => userRepository.isLoggedIn;
  UserModel? get user => userRepository.user;

  UserModel? _userDetails;
  UserModel? get userDetails => _userDetails;

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
        isApproved: false,
        createdDate: DateTime.now(),
      );

      final result = await insertUser(userModel: userModel);
      checkError(response);
      return result;
    }

    checkError(response);
    return false;
  }

  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final response = await userRepository.loginWithEmailPassword(
      email: email,
      password: password,
    );

    if (response.data is User) {
      //get user details from API
    }

    checkError(response);
    return response.data is User;
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

  Future<String> uploadImage({
    required String storageRef,
    File? image,
    List<File>? images,
  }) async {
    final response = await userRepository.uploadPhoto(
      storageRef: storageRef,
      image: image,
      images: images,
    );

    checkError(response);
    return response.data;
  }

  Future<void> getUserDetails({required String userID}) async {
    final response = await userRepository.getUserDetails(userID: userID);

    if (response.data is UserModel) {
      _userDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> updateUser({
    required String? userID,
    required String? emailAddress,
    required String? password,
    required String? userRole,
    required String? firstName,
    required String? lastName,
    required String? fullName,
    required String? gender,
    required String? phoneNumber,
    required String? address,
    required String? vehicleType,
    required String? vehiclePlateNumber,
    required String? companyName,
    required bool? isApproved,
    required DateTime? createdDate,
    required String? profileImageURL,
    File? profileImage,
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
    print('New Profile Image URL: $newProfileImageURL');
    UserModel usermodel = UserModel(
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
      isApproved: isApproved ?? false,
      createdDate: createdDate ?? DateTime.now(),
    );

    final response = await userRepository.updateUser(
      userID: userID ?? '',
      userModel: usermodel,
    );

    checkError(response);
    return response.data is ErrorModel;
  }
}
