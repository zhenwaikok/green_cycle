import 'package:green_cycle_fyp/viewmodel/awareness_view_model.dart';
import 'package:green_cycle_fyp/viewmodel/reward_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

enum HttpMethod { get, post, put, delete }

class APIValues {
  APIValues._();

  //change host url later
  static const hostUrl = 'https://10.0.2.2:7068/GreenCycleAPI';
}

List<SingleChildWidget> providerAssets() => [
  ChangeNotifierProvider.value(value: AwarenessViewModel()),
  ChangeNotifierProvider.value(value: RewardViewModel()),
];
