import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class LocationServices extends BaseServices {
  Future<MyResponse> convertCoordinatesToAddress({
    required LatLng latLng,
  }) async {
    String path =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=${EnvValues.googleApiKey}';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> calculateDistance({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
  }) async {
    String path =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${originLatLng.latitude},${originLatLng.longitude}&destination=${destinationLatLng.latitude},${destinationLatLng.longitude}&key=${EnvValues.googleApiKey}';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }
}
