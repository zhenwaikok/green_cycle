import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

enum HttpMethod { get, post, put, delete }

class APIValues {
  APIValues._();

  //change host url later
  static const hostUrl = 'https://10.0.2.2:7068/GreenCycleAPI';
}

List<SingleChildWidget> providerAssets() => [
  ChangeNotifierProvider.value(
    value: AwarenessViewModel(
      awarenessRepository: AwarenessRepository(
        awarenessServices: AwarenessServices(),
      ),
      firebaseRepository: FirebaseRepository(
        firebaseServices: FirebaseServices(),
      ),
    ),
  ),
  ChangeNotifierProvider.value(
    value: RewardViewModel(
      rewardRepository: RewardRepository(),
      firebaseRepository: FirebaseRepository(
        firebaseServices: FirebaseServices(),
      ),
    ),
  ),
  ChangeNotifierProvider.value(
    value: UserViewModel(
      userRepository: UserRepository(
        sharePreferenceHandler: SharedPreferenceHandler(),
        userServices: UserServices(),
      ),
      firebaseRepository: FirebaseRepository(
        firebaseServices: FirebaseServices(),
      ),
    ),
  ),
];

class RegexConstants {
  static final malaysianPhoneRegex = RegExp(r'^(?:\+?60|0)1[0-46-9]\d{7,8}$');
}

class DropDownItems {
  DropDownItems._();

  static const List<String> vehicleTypes = ['Car', 'Truck', 'Van'];
  static const List<String> roles = ['Customer', 'Collector'];
  static const List<String> genders = ['Male', 'Female'];
  static final List<String> sortByItems = ['All', 'Oldest', 'Latest'];
}
