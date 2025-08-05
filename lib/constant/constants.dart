import 'package:green_cycle_fyp/constant/images_manager.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/repository/firebase_repository.dart';
import 'package:green_cycle_fyp/repository/item_listing_repository.dart';
import 'package:green_cycle_fyp/repository/location_repository.dart';
import 'package:green_cycle_fyp/repository/pickup_request_repository.dart';
import 'package:green_cycle_fyp/repository/reward_repository.dart';
import 'package:green_cycle_fyp/repository/user_repository.dart';
import 'package:green_cycle_fyp/services/awareness_services.dart';
import 'package:green_cycle_fyp/services/firebase_services.dart';
import 'package:green_cycle_fyp/services/user_services.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';
import 'package:green_cycle_fyp/view/onboarding_screen.dart';
import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/item_listing_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/location_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/pickup_request_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

enum HttpMethod { get, post, put, delete }

class EnvValues {
  EnvValues._();

  static const googleApiKey = String.fromEnvironment('google_api_key');
  static const hostUrl = String.fromEnvironment('hostUrl');
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
  ChangeNotifierProvider.value(
    value: LocationViewModel(locationRepository: LocationRepository()),
  ),
  ChangeNotifierProvider.value(
    value: PickupRequestViewModel(
      firebaseRepository: FirebaseRepository(
        firebaseServices: FirebaseServices(),
      ),
      pickupRequestRepository: PickupRequestRepository(),
      userRepository: UserRepository(
        sharePreferenceHandler: SharedPreferenceHandler(),
        userServices: UserServices(),
      ),
    ),
  ),
  ChangeNotifierProvider.value(
    value: ItemListingViewModel(
      itemListingRepository: ItemListingRepository(),
      firebaseRepository: FirebaseRepository(
        firebaseServices: FirebaseServices(),
      ),
      userRepository: UserRepository(
        sharePreferenceHandler: SharedPreferenceHandler(),
        userServices: UserServices(),
      ),
    ),
  ),
];

class RegexConstants {
  static final malaysianPhoneRegex = RegExp(r'^(?:\+?60|0)1[0-46-9]\d{7,8}$');
  static final priceRegex = RegExp(r'^\d*\.?\d{0,2}');
}

class DropDownItems {
  DropDownItems._();

  static const List<String> vehicleTypes = ['Car', 'Truck', 'Van'];
  static const List<String> roles = ['Customer', 'Collector'];
  static const List<String> genders = ['Male', 'Female'];
  static const List<String> sortByItems = ['All', 'Oldest', 'Latest'];
  static const List<String> collectorManagementSortByItems = [
    'All',
    'Collector Name: A-Z',
    'Collector Name: Z - A',
    'Approved',
    'Pending',
    'Latest',
  ];
  static const List<String> itemCategoryItems = [
    'Large Household Appliances',
    'Small Household Appliances',
    'Consumer Electronics',
    'Information & Communication Technology (ICT)',
    'Lighting Equipment',
    'Batteries & Accumulators',
    'Electrical & Electronic Tools',
    'Medical Devices',
    'Monitoring & Control Instruments',
  ];
  static const List<String> pickUpTimeOptions = [
    '8:00 AM - 10:00 AM',
    '10:00 AM - 12:00 PM',
    '12:00 PM - 2:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
  ];
  static const List<String> requestDropdownItems = [
    'All Requests',
    'Pending',
    'Accepted',
    'In Progress',
    'Arrived',
    'Completed',
  ];
  static const List<String> itemListingConditionItems = [
    'Brand New',
    'Like New',
    'Very Good',
    'Good',
  ];
  static const List<String> itemListingSortByItems = [
    'All',
    'Ascending Name',
    'Descending Name',
    'Price: Low-High',
    'Price: High-Low',
  ];
}

class OnboardData {
  OnboardData._();

  static final List<OnBoard> onboardData = [
    OnBoard(
      image: Images.onboarding1,
      title: 'Dispose E-Waste Responsibly',
      description:
          'Electronic waste is harmful to the environment if not recycled properly. Our app helps you dispose of gadgets, appliances, and batteries the right way — with just a few taps.',
    ),
    OnBoard(
      image: Images.onboarding2,
      title: 'Simple, Seamless, Sustainable',
      description:
          'Book a pickup, track your collector in real-time, and let us do the rest. Whether you are a user or a collector, we make e-waste recycling easy and efficient.',
    ),
    OnBoard(
      image: Images.onboarding3,
      title: 'You Make a Difference',
      description:
          'Every pickup reduces toxic waste and protects our planet. Join us in building a cleaner, greener future!',
    ),
  ];
}
