import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/firebase_options.dart';
import 'package:green_cycle_fyp/utils/shared_prefrences_handler.dart';

/// Function to perform all initial configuration based on running environment
/// Any method, feature that requires to init()/start() before app running, may do it here
Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceHandler().initialize();
}
