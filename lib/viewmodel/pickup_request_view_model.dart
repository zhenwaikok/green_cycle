import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/pickup_request/pickup_request_model.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class PickupRequestViewModel extends BaseViewModel {
  PickupRequestViewModel({
    required this.firebaseRepository,
    required this.pickupRequestRepository,
    required this.userRepository,
  });

  final FirebaseRepository firebaseRepository;
  final PickupRequestRepository pickupRequestRepository;
  final UserRepository userRepository;

  UserModel? get user => userRepository.user;

  List<PickupRequestModel> _pickupRequestList = [];
  PickupRequestModel? _pickupRequestDetails;
  PickupRequestModel? get pickupRequestDetails => _pickupRequestDetails;
  List<PickupRequestModel> get pickupRequestList => _pickupRequestList;

  String? pickupLocation;
  LatLng? selectedLatLng;
  String? remarks;
  DateTime? pickupDate;
  String? pickupTimeRange;
  List<ImageFile> pickupItemImages = [];
  String? pickupItemDescription;
  String? pickupItemCategory;
  int? pickupItemQuantity;
  String? pickupItemCondition;

  void updateLocation({
    required String pickupLocation,
    required LatLng selectedLatLng,
    String? remarks,
  }) {
    this.pickupLocation = pickupLocation;
    this.selectedLatLng = selectedLatLng;
    this.remarks = remarks;
    notifyListeners();
  }

  void updatePickupDateAndTime({
    required DateTime pickupDate,
    required String pickupTimeRange,
  }) {
    this.pickupDate = pickupDate;
    this.pickupTimeRange = pickupTimeRange;
    notifyListeners();
  }

  void updatePickupItemDetails({
    required List<ImageFile> pickupItemImages,
    required String pickupItemDescription,
    required String pickupItemCategory,
    required int pickupItemQuantity,
    required String pickupItemCondition,
  }) {
    this.pickupItemImages = pickupItemImages;
    this.pickupItemDescription = pickupItemDescription;
    this.pickupItemCategory = pickupItemCategory;
    this.pickupItemQuantity = pickupItemQuantity;
    this.pickupItemCondition = pickupItemCondition;
    notifyListeners();
  }

  void clearAll() {
    pickupLocation = null;
    selectedLatLng = null;
    remarks = null;
    pickupDate = null;
    pickupTimeRange = null;
    pickupItemImages.clear();
    pickupItemDescription = null;
    pickupItemCategory = null;
    pickupItemQuantity = null;
    pickupItemCondition = null;
    notifyListeners();
  }

  Future<void> getPickupRequestsWithUserID() async {
    final userID = user?.userID ?? '';

    final response = await pickupRequestRepository.getPickupRequestsWithUserID(
      userID: userID,
    );

    if (response.data is List<PickupRequestModel>) {
      _pickupRequestList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getPickupRequestDetails({
    required String pickupRequestID,
  }) async {
    final response = await pickupRequestRepository.getPickupRequestDetails(
      requestID: pickupRequestID,
    );

    print('response viewmodel : ${response.data}');

    if (response.data is PickupRequestModel) {
      _pickupRequestDetails = response.data;
      print('Pickup Request Details: ${_pickupRequestDetails}');
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> insertPickupRequest() async {
    List<String> imageURL = [];

    final List<File> imageFiles = pickupItemImages
        .where((img) => img.hasPath)
        .map((img) => File(img.path ?? ''))
        .toList();

    final uploadImageResponse = await uploadImage(
      storageRef: 'PickupRequestItemImages',
      images: imageFiles,
    );
    imageURL = uploadImageResponse;

    final pickupRequestID = generatePickupRequestID();

    PickupRequestModel pickupRequestModel = PickupRequestModel(
      pickupRequestID: pickupRequestID,
      userID: user?.userID,
      collectorUserID: null,
      pickupLocation: pickupLocation,
      remarks: remarks,
      pickupDate: pickupDate,
      pickupTimeRange: pickupTimeRange,
      pickupItemImageURL: imageURL,
      pickupItemDescription: pickupItemDescription,
      pickupItemCategory: pickupItemCategory,
      pickupItemQuantity: pickupItemQuantity,
      pickupItemCondition: pickupItemCondition,
      pickupRequestStatus: 'Pending',
      collectionProofImageURL: null,
      requestedDate: DateTime.now(),
      completedDate: null,
    );

    final insertPickupRequestResponse = await pickupRequestRepository
        .insertPickupRequest(pickupRequestModel: pickupRequestModel);

    checkError(insertPickupRequestResponse);
    return insertPickupRequestResponse.data is PickupRequestModel;
  }

  Future<bool> deletePickupRequest({required String pickupRequestID}) async {
    final response = await pickupRequestRepository.deletePickupRequest(
      requestID: pickupRequestID,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }

  Future<List<String>> uploadImage({
    required String storageRef,
    List<File>? images,
  }) async {
    final response = await firebaseRepository.uploadPhoto(
      storageRef: storageRef,
      images: images,
    );

    checkError(response);
    return response.data;
  }

  String generatePickupRequestID() {
    final millis = DateTime.now().millisecondsSinceEpoch;
    return 'REQ${millis % 1000000}';
  }
}
