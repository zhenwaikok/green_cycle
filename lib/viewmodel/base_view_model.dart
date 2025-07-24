import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';

/// A base class to unified all the required common fields and functions
/// Inherited with ChangeNotifier for Provider State Management
/// All inheriting classes will be able to access these values and features
class BaseViewModel with ChangeNotifier {
  /// response that view layer listening for data changes
  /// view layer may perform data update or any Ui logic depends on response status
  MyResponse response = MyResponse.initial();

  /// Unified method to call Provider [notifyListeners()] to update [response] value.
  void notify(MyResponse newResponse) {
    response = newResponse;
    notifyListeners();
  }

  /// Reset [response] to mark the response as consumed.
  void consumed() {
    response = MyResponse.initial();
  }
}
