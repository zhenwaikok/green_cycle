import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/collector_locations_model/collector_locations_model.dart';
import 'package:green_cycle_fyp/model/direction_reponse_model/direction_response_model.dart'
    hide LatLng;
import 'package:green_cycle_fyp/model/geocoding_response_model/geocoding_response_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/services/location_services.dart';
import 'package:green_cycle_fyp/utils/background_service.dart';

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

  Future<MyResponse> calculateDistance({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
  }) async {
    final response = await _locationServices.calculateDistance(
      originLatLng: originLatLng,
      destinationLatLng: destinationLatLng,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = DirectionResponseModel.fromJson(response.data);

      final distance =
          resultModel.routes!.firstOrNull?.legs?.firstOrNull?.distance?.value;
      if (distance != null) {
        return MyResponse.complete(distance);
      }
    }

    return response;
  }

  Future<MyResponse> getAllCollectorLocations() async {
    final response = await _locationServices.getAllCollectorLocations();

    if (response.data is List) {
      final resultModel = (response.data as List)
          .map((json) => CollectorLocationsModel.fromJson(json))
          .toList();
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> insertCollectorLocations({
    required CollectorLocationsModel collectorLocationsModel,
  }) async {
    final response = await _locationServices.insertCollectorLocations(
      collectorLocationsModel: collectorLocationsModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = CollectorLocationsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> getCollectorLocationsWithCollectorUserID({
    required String collectorUserID,
  }) async {
    final response = await _locationServices
        .getCollectorLocationsWithCollectorUserID(
          collectorUserID: collectorUserID,
        );

    print('Collector ressponse: ${response.data}');

    if (response.data is Map<String, dynamic>) {
      final resultModel = CollectorLocationsModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> updateCollectorLocations({
    required String collectorUserID,
    required CollectorLocationsModel collectorLocationsModel,
  }) async {
    final response = await _locationServices.updateCollectorLocations(
      collectorUserID: collectorUserID,
      collectorLocationsModel: collectorLocationsModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ApiResponseModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  Future<MyResponse> deleteCollectorLocations({
    required String collectorUserID,
  }) async {
    final response = await _locationServices.deleteCollectorLocations(
      collectorUserID: collectorUserID,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = ApiResponseModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }
    return response;
  }

  void startTrackingService({required String collectorUserID}) {
    startTracking(collectorUserID: collectorUserID);
  }

  void stopBackgroundTrackingService() {
    stopBackgroundService();
  }
}
