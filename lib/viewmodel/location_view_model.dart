import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/collector_locations_model/collector_locations_model.dart';
import 'package:green_cycle_fyp/repository/location_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';
import 'package:location/location.dart' hide LocationAccuracy;

class LocationViewModel extends BaseViewModel {
  LocationViewModel({required this.locationRepository});
  LocationRepository locationRepository;

  CollectorLocationsModel? _collectorLocationDetails;

  CollectorLocationsModel? get collectorLocationDetails =>
      _collectorLocationDetails;

  void startTrackingService({required String collectorUserID}) {
    locationRepository.startTrackingService(collectorUserID: collectorUserID);
  }

  void stopBackgroundTrackingService() {
    locationRepository.stopBackgroundTrackingService();
  }

  Future<String> convertCoordinatesToAddress({required LatLng latLng}) async {
    final response = await locationRepository.convertCoordinatesToAddress(
      latLng: latLng,
    );

    checkError(response);
    return response.data;
  }

  Future<int> calculateDistance({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
  }) async {
    final response = await locationRepository.calculateDistance(
      originLatLng: originLatLng,
      destinationLatLng: destinationLatLng,
    );

    checkError(response);
    return response.data;
  }

  Future<Position?> currentLocation() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      serviceEnable = await Location().requestService();
      if (!serviceEnable) {
        return null;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } on LocationServiceDisabledException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Stream<Position> streamLocation() async* {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    yield* Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future<void> getCollectorLocations({required String collectorUserID}) async {
    final response = await locationRepository
        .getCollectorLocationsWithCollectorUserID(
          collectorUserID: collectorUserID,
        );

    if (response.data is CollectorLocationsModel) {
      _collectorLocationDetails = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> insertCollectorLocations({
    required String collectorUserID,
  }) async {
    final position = await currentLocation();

    CollectorLocationsModel collectorLocationsModel = CollectorLocationsModel(
      collectorUserID: collectorUserID,
      collectorLatitude: position?.latitude,
      collectorLongtitude: position?.longitude,
      lastUpdated: DateTime.now(),
    );

    final response = await locationRepository.insertCollectorLocations(
      collectorLocationsModel: collectorLocationsModel,
    );

    checkError(response);
    return response.data is CollectorLocationsModel;
  }

  Future<bool> updateCollectorLocations({
    required String collectorUserID,
    required double collectorLatitude,
    required double collectorLongtitude,
  }) async {
    CollectorLocationsModel collectorLocationsModel = CollectorLocationsModel(
      collectorUserID: collectorUserID,
      collectorLatitude: collectorLatitude,
      collectorLongtitude: collectorLongtitude,
      lastUpdated: DateTime.now(),
    );

    final response = await locationRepository.updateCollectorLocations(
      collectorUserID: collectorUserID,
      collectorLocationsModel: collectorLocationsModel,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }

  Future<bool> deleteCollectorLocations({
    required String collectorUserID,
  }) async {
    final response = await locationRepository.deleteCollectorLocations(
      collectorUserID: collectorUserID,
    );

    checkError(response);
    return response.data is ApiResponseModel;
  }
}
