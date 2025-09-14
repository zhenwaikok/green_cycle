import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/api_model/api_response_model/api_response_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';

abstract class BaseServices {
  BaseServices() {
    _init();
  }

  static BaseServices? _instance;
  static String? hostUrl = EnvValues.hostUrl;
  static String? stripeHostUrl = EnvValues.stripeHostUrl;
  static String? fcmHostUrl = EnvValues.fcmHostUrl;

  String apiUrl() => hostUrl ?? '';
  String stripeUrl() => stripeHostUrl ?? '';
  String fcmUrl() => fcmHostUrl ?? '';

  Dio? _dio;

  Dio? get dio {
    if (_instance == null || _instance?._dio == null) {
      _instance?._init();
    }
    return _instance?._dio;
  }

  /// Generate the stripe secret key with Bearer Authentication format
  String get auth {
    return 'Bearer ${EnvValues.stripeSecretKey}';
  }

  void _init() {
    _instance = this;
    _dio = Dio(
      BaseOptions(
        headers: <String, String>{'Content-Type': ContentType.json.value},
      ),
    );
  }

  Future<MyResponse> callAPI({
    required HttpMethod httpMethod,
    required String path,
    dynamic postBody,
    bool isStripe = false,
    bool isNotification = false,
    String? notificationAuth,
  }) async {
    try {
      Response? response;

      if (isStripe) {
        dio?.options.headers['Content-Type'] =
            'application/x-www-form-urlencoded';
        dio?.options.headers['Authorization'] = auth;
      }

      if (isNotification) {
        dio?.options.headers['Content-Type'] = 'application/json';
        dio?.options.headers['Authorization'] = notificationAuth;
      }

      switch (httpMethod) {
        case HttpMethod.get:
          print('calling get');
          response = await dio?.get(path);
          break;
        case HttpMethod.post:
          print('calling post');
          response = await dio?.post(path, data: postBody);
          break;
        case HttpMethod.put:
          response = await dio?.put(path, data: postBody);
          break;
        case HttpMethod.delete:
          response = await dio?.delete(path);
          break;
      }

      debugPrint('Response: ${response?.statusCode}');

      if (response?.statusCode == HttpStatus.ok ||
          response?.statusCode == HttpStatus.created) {
        debugPrint('OK');
        return MyResponse.complete(response?.data);
      } else {
        debugPrint('Error: ${response?.statusCode}');
      }
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        var processedError = ApiResponseModel.fromJson(
          e.response?.data,
        ).copyWith(status: e.response?.statusCode);

        debugPrint('error status code: ${e.response?.statusCode}');
        debugPrint('error: ${e.response?.data}');

        debugPrint('API Call Error: ${processedError.message}');

        return MyResponse.error(processedError.toJson());
      } else if (e is DioException) {
        String? message;

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            message = 'Opps, something went wrong. Please try again later.';
            debugPrint('Connection timeout');
          case DioExceptionType.connectionError:
            message =
                'Network connection failed. Please check your internet connection.';
            debugPrint('Network connection failed');
          default:
            message = e.message;
            debugPrint('Error: ${e.message}');
        }

        debugPrint('Error calling API: $message');

        return MyResponse.error(
          ApiResponseModel(
            status: e.response?.statusCode,
            message: message,
          ).toJson(),
        );
      }
      return MyResponse.error(e.toString());
    }

    debugPrint('Error calling API');
    return MyResponse.error(
      DioException(requestOptions: RequestOptions(path: path)),
    );
  }
}
