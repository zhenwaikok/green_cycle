import 'dart:io';
import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/model/api_model/user/user_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ItemListingViewModel extends BaseViewModel {
  ItemListingViewModel({
    required this.itemListingRepository,
    required this.firebaseRepository,
    required this.userRepository,
  });

  ItemListingRepository itemListingRepository;
  FirebaseRepository firebaseRepository;
  UserRepository userRepository;

  ItemListingModel? _itemListingDetails;
  List<ItemListingModel> _itemListings = [];
  UserModel? _user;

  ItemListingModel? get itemListingDetails => _itemListingDetails;
  List<ItemListingModel> get itemListings => _itemListings;
  UserModel? get user => _user;

  Future<void> getAllItemListings() async {
    final response = await itemListingRepository.getAllItemListings();

    if (response.data is List<ItemListingModel>) {
      _itemListings = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getItemListingWithUserID() async {
    final userID = userRepository.user?.userID ?? '';

    final response = await itemListingRepository.getItemListingWithUserID(
      userID: userID,
    );

    if (response.data is List<ItemListingModel>) {
      _itemListings = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getItemListingDetails({required int itemListingID}) async {
    final response = await itemListingRepository.getItemListingDetails(
      itemListingID: itemListingID,
    );

    if (response.data is ItemListingModel) {
      _itemListingDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> insertItemListing({
    required List<ImageFile> itemImages,
    required String itemName,
    required String itemDescription,
    required double itemPrice,
    required String itemCondition,
    required String itemCategory,
  }) async {
    List<String> imageURL = [];

    final imageFiles = WidgetUtil.convertImageFileToFile(images: itemImages);

    final uploadImageResponse = await uploadImage(
      storageRef: 'ItemListingImages',
      images: imageFiles,
    );
    imageURL = uploadImageResponse;

    ItemListingModel itemListingModel = ItemListingModel(
      userID: _user?.userID ?? '',
      itemImageURL: imageURL,
      itemName: itemName,
      itemDescription: itemDescription,
      itemPrice: itemPrice,
      itemCondition: itemCondition,
      itemCategory: itemCategory,
      isSold: false,
      status: 'Active',
      createdDate: DateTime.now(),
    );

    final response = await itemListingRepository.insertItemListing(
      itemListingModel: itemListingModel,
    );

    checkError(response);
    return response.data is ItemListingModel;
  }

  Future<bool> updateItemListing({
    List<ImageFile>? itemImages,
    required String itemName,
    required String itemDescription,
    required double itemPrice,
    required String itemCondition,
    required String itemCategory,
    bool? isSold,
    int? itemListingID,
    String? userID,
    String? status,
    DateTime? createdDate,
    List<String>? imageURLs,
  }) async {
    List<String> finalImageURLs = [];
    List<ImageFile> newImageFiles = [];

    if (itemImages?.isNotEmpty == true) {
      for (var image in itemImages ?? []) {
        if (image.path?.startsWith('http') ?? false) {
          finalImageURLs.add(image.path ?? '');
        } else {
          newImageFiles.add(image);
        }
      }
    }

    if (newImageFiles.isNotEmpty) {
      final imageFiles = WidgetUtil.convertImageFileToFile(
        images: newImageFiles,
      );

      final uploadImageResponse = await uploadImage(
        storageRef: 'ItemListingImages',
        images: imageFiles,
      );
      finalImageURLs.addAll(uploadImageResponse);
    }

    ItemListingModel itemListingModel = ItemListingModel(
      itemListingID: itemListingID ?? _itemListingDetails?.itemListingID ?? 0,
      userID: userID ?? userRepository.user?.userID ?? '',
      itemImageURL: imageURLs ?? finalImageURLs,
      itemName: itemName,
      itemDescription: itemDescription,
      itemPrice: itemPrice,
      itemCondition: itemCondition,
      itemCategory: itemCategory,
      isSold: isSold ?? _itemListingDetails?.isSold,
      status: status ?? _itemListingDetails?.status,
      createdDate: createdDate ?? _itemListingDetails?.createdDate,
    );

    final response = await itemListingRepository.updateItemListing(
      itemListingID: itemListingID ?? _itemListingDetails?.itemListingID ?? 0,
      itemListingModel: itemListingModel,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }

  Future<bool> deleteItemListing({required int itemListingID}) async {
    final response = await itemListingRepository.deleteItemListing(
      itemListingID: itemListingID,
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
}
