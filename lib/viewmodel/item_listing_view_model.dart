import 'dart:io';
import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/api_model/item_listing/item_listing_model.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ItemListingViewModel extends BaseViewModel {
  ItemListingViewModel({
    required this.itemListingRepository,
    required this.firebaseRepository,
  });

  ItemListingRepository itemListingRepository;
  FirebaseRepository firebaseRepository;

  ItemListingModel? _itemListingDetails;
  List<ItemListingModel> _itemListings = [];

  ItemListingModel? get itemListingDetails => _itemListingDetails;
  List<ItemListingModel> get itemListings => _itemListings;

  Future<void> getAllItemListings() async {
    final response = await itemListingRepository.getAllItemListings();

    if (response.data is List<ItemListingModel>) {
      _itemListings = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<void> getItemListingWithUserID({required String userID}) async {
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
    required String userID,
  }) async {
    List<String> imageURL = [];

    final imageFiles = WidgetUtil.convertImageFileToFile(images: itemImages);

    final uploadImageResponse = await uploadImage(
      storageRef: 'ItemListingImages',
      images: imageFiles,
    );
    imageURL = uploadImageResponse;

    ItemListingModel itemListingModel = ItemListingModel(
      userID: userID,
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
    required String userID,
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
      userID: userID,
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

  void sortListings({
    required List<ItemListingModel> itemListingList,
    required String selectedSort,
    required List<String> sortByItems,
  }) {
    if (selectedSort == sortByItems[1]) {
      itemListingList.sort(
        (a, b) =>
            a.itemName?.toLowerCase().compareTo(
              b.itemName?.toLowerCase() ?? '',
            ) ??
            0,
      );
    } else if (selectedSort == sortByItems[2]) {
      itemListingList.sort(
        (a, b) =>
            b.itemName?.toLowerCase().compareTo(
              a.itemName?.toLowerCase() ?? '',
            ) ??
            0,
      );
    } else if (selectedSort == sortByItems[3]) {
      itemListingList.sort(
        (a, b) => a.itemPrice?.compareTo(b.itemPrice ?? 0) ?? 0,
      );
    } else if (selectedSort == sortByItems[4]) {
      itemListingList.sort(
        (a, b) => b.itemPrice?.compareTo(a.itemPrice ?? 0) ?? 0,
      );
    } else {
      itemListingList.sort(
        (a, b) =>
            b.createdDate?.compareTo(a.createdDate ?? DateTime.now()) ?? 0,
      );
    }
  }
}
