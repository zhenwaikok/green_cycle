import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/model/geocoding_response_model/geocoding_response_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/location_services.dart';

class LocationRepository {
  LocationServices get _locationServices => LocationServices();

  Future<MyResponse> convertCoordinatesToAddress({
    required LatLng latLng,
  }) async {
    final response = await _locationServices.convertCoordinatesToAddress(
      latLng: latLng,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = GeocodingResponseModel.fromJson(response.data);

      final firstAddress = resultModel.results?.firstOrNull?.formattedAddress;
      if (firstAddress != null) {
        return MyResponse.complete(firstAddress);
      } else {
        return MyResponse.error('No address found');
      }
    }
    return response;
  }
}
