import 'dart:io';

import 'package:dio/dio.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/error_model.dart';
import 'package:green_cycle_fyp/model/network/Response.dart';

abstract class BaseServices {
  BaseServices() {
    _init();
  }

  static BaseServices? _instance;
  static String? hostUrl = APIValues.hostUrl;
  String apiUrl() => hostUrl ?? '';

  Dio? _dio;

  Dio? get dio {
    if (_instance == null || _instance?._dio == null) {
      _instance?._init();
    }
    return _instance?._dio;
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
  }) async {
    try {
      Response? response;

      switch (httpMethod) {
        case HttpMethod.get:
          print('api calling');
          response = await dio?.get(path);
          break;
        case HttpMethod.post:
          response = await dio?.post(path, data: postBody);
          break;
        case HttpMethod.put:
          response = await dio?.put(path, data: postBody);
          break;
        case HttpMethod.delete:
          response = await dio?.delete(path);
          break;
      }

      print('Response status code: ${response?.statusCode}');
      print('Response is $response');

      if (response?.statusCode == HttpStatus.ok) {
        print('API Call Success: ${response?.data}');
        return MyResponse.complete(response?.data);
      }
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        var processedError = ErrorModel.fromJson(e.response?.data);
        processedError.statusCode = e.response?.statusCode;

        print('API Call Error: ${processedError.message}');
        return MyResponse.error(processedError.toJson());
      } else if (e is DioException) {
        String? message;

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            message = 'Opps, something went wrong. Please try again later.';
          case DioExceptionType.connectionError:
            message =
                'Network connection failed. Please check your internet connection.';
          default:
            message = e.message;
        }

        print('API Call Error: $message');
        return MyResponse.error(
          ErrorModel(
            statusCode: e.response?.statusCode,
            message: message,
          ).toJson(),
        );
      }
      return MyResponse.error(e.toString());
    }

    print('API Call Failed: No response or invalid status code');
    return MyResponse.error(
      DioException(requestOptions: RequestOptions(path: path)),
    );
  }
}
