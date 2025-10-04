import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/collector_locations_model/collector_locations_model.dart';
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

  Future<MyResponse> getAllCollectorLocations() async {
    String path = '${apiUrl()}/CollectorLocations';

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> insertCollectorLocations({
    required CollectorLocationsModel collectorLocationsModel,
  }) async {
    String path = '${apiUrl()}/CollectorLocations';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: collectorLocationsModel.toJson(),
    );
  }

  Future<MyResponse> getCollectorLocationsWithCollectorUserID({
    required String collectorUserID,
  }) async {
    String path = '${apiUrl()}/CollectorLocations/$collectorUserID';
    print('Collector User ID: $collectorUserID');
    print('path: $path');

    return callAPI(httpMethod: HttpMethod.get, path: path);
  }

  Future<MyResponse> updateCollectorLocations({
    required String collectorUserID,
    required CollectorLocationsModel collectorLocationsModel,
  }) async {
    String path = '${apiUrl()}/CollectorLocations/$collectorUserID';

    return callAPI(
      httpMethod: HttpMethod.put,
      path: path,
      postBody: collectorLocationsModel.toJson(),
    );
  }

  Future<MyResponse> deleteCollectorLocations({
    required String collectorUserID,
  }) async {
    String path = '${apiUrl()}/CollectorLocations/$collectorUserID';

    return callAPI(httpMethod: HttpMethod.delete, path: path);
  }
}
