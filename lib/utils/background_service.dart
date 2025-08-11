import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:green_cycle_fyp/repository/location_repository.dart';
import 'package:green_cycle_fyp/viewmodel/location_view_model.dart';

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke('stopService');
}

void startTracking({required String collectorUserID}) {
  final service = FlutterBackgroundService();
  service.invoke('startTracking', {'collectorUserID': collectorUserID});
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: true,
      onStart: onStart,
      isForegroundMode: true,
      autoStartOnBoot: true,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  print('Background service started');

  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "GreenCycle Tracking",
      content: "Collector location is being updated",
    );
  }

  final locationVM = LocationViewModel(
    locationRepository: LocationRepository(),
  );

  service.on('stopService').listen((event) {
    service.stopSelf();
    print("Background tracking stopped");
  });

  service.on('startTracking').listen((event) async {
    final collectorUserID = event?['collectorUserID'] ?? '';
    if (collectorUserID.isEmpty) {
      print("collectorUserID is missing, cannot start tracking");
      return;
    }

    print("Tracking started for: $collectorUserID");

    locationVM.streamLocation().listen((position) async {
      final result = await locationVM.updateCollectorLocations(
        collectorUserID: collectorUserID,
        collectorLatitude: position.latitude,
        collectorLongtitude: position.longitude,
      );

      if (result) {
        print("Collector location updated successfully");
      } else {
        print("Failed to update collector location");
      }
    });
  });
}
