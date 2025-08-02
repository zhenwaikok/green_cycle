import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/repository/location_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class LocationViewModel extends BaseViewModel {
  LocationViewModel({required this.locationRepository});
  LocationRepository locationRepository;

  Future<String> convertCoordinatesToAddress({required LatLng latLng}) async {
    final response = await locationRepository.convertCoordinatesToAddress(
      latLng: latLng,
    );

    checkError(response);
    return response.data;
  }

  Future<Position> currentLocation() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
