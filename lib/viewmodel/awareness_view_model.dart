import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class AwarenessViewModel extends BaseViewModel {
  List<AwarenessModel> awarenessList = [];
  AwarenessModel? awarenessDetails;
  final _awarenessRepository = AwarenessRepository();

  Future<void> getAwarenessList() async {
    notify(MyResponse.loading());

    try {
      final response = await _awarenessRepository.getAllAwareness();
      if (response.data is List<AwarenessModel>) {
        awarenessList = response.data;
        notify(MyResponse.complete(awarenessList));
      } else if (response.status == ResponseStatus.error) {
        final errorResponse = (response.error);
        notify(MyResponse.error(errorResponse));
      }
    } catch (e) {
      debugPrint('error: $e');
      notify(MyResponse.error(e.toString()));
      rethrow;
    }
  }

  Future<void> getAwarenessDetails({required int awarenessID}) async {
    notify(MyResponse.loading());

    try {
      final response = await _awarenessRepository.getAwarenessDetails(
        awarenessID: awarenessID,
      );
      if (response.data is AwarenessModel) {
        awarenessDetails = response.data;
        notify(MyResponse.complete(awarenessDetails));
      } else if (response.status == ResponseStatus.error) {
        final errorResponse = (response.error);
        notify(MyResponse.error(errorResponse));
      }
    } catch (e) {
      debugPrint('error: $e');
      notify(MyResponse.error(e.toString()));
      rethrow;
    }
  }

  Future<bool> addAwareness({
    required String awarenessTitle,
    required String awarenessContent,
  }) async {
    notify(MyResponse.loading());

    try {
      //upload image to firebase then get image url first

      final response = await _awarenessRepository.insertAwareness(
        awarenessModel: AwarenessModel(
          awarenessImageURL: '',
          awarenessTitle: awarenessTitle,
          awarenessContent: awarenessContent,
          createdDate: DateTime.now(),
        ),
      );

      if (response.data is AwarenessModel) {
        notify(MyResponse.complete(response.data));
        return true;
      } else if (response.status == ResponseStatus.error) {
        notify(MyResponse.error(response.error));
        return false;
      }
    } catch (e) {
      debugPrint('error: $e');
      notify(MyResponse.error(e.toString()));
      return false;
    }

    return false;
  }
}
