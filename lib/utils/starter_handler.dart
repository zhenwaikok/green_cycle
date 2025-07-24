import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';

/// Function to perform all initial configuration based on running environment
/// Any method, feature that requires to init()/start() before app running, may do it here
Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHandler().initialize();
}
