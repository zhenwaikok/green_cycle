import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

@freezed
class ErrorModel with _$ErrorModel {
  const factory ErrorModel({int? statusCode, String? message}) = _ErrorModel;

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
}

extension ErrorModelX on ErrorModel {
  bool get isUrgentError {
    return statusCode == 401 || statusCode == 500;
  }
}
