import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/error/error_model.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';

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

    // For development only - accept self-signed certificates
    (_dio?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
          client.badCertificateCallback = (cert, host, port) => true;
          return client;
        };
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
          print('calling get');
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

      print('Response: ${response?.statusCode}');

      if (response?.statusCode == HttpStatus.ok) {
        print('OK');
        return MyResponse.complete(response?.data);
      } else {
        print('Error: ${response?.statusCode}');
      }
    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        var processedError = ErrorModel.fromJson(
          e.response?.data,
        ).copyWith(statusCode: e.response?.statusCode);

        print('API Call Error: ${processedError.message}');

        return MyResponse.error(processedError.toJson());
      } else if (e is DioException) {
        String? message;

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            message = 'Opps, something went wrong. Please try again later.';
            print('Connection timeout');
          case DioExceptionType.connectionError:
            message =
                'Network connection failed. Please check your internet connection.';
            print('Network connection failed');
          default:
            message = e.message;
            print('Error: ${e.message}');
        }

        print('Error calling API: $message');

        return MyResponse.error(
          ErrorModel(
            statusCode: e.response?.statusCode,
            message: message,
          ).toJson(),
        );
      }
      return MyResponse.error(e.toString());
    }

    print('Error calling API');
    return MyResponse.error(
      DioException(requestOptions: RequestOptions(path: path)),
    );
  }
}
