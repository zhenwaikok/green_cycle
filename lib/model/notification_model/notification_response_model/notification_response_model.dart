import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_response_model.freezed.dart';
part 'notification_response_model.g.dart';

@freezed
class NotificationResponseModel with _$NotificationResponseModel {
  const factory NotificationResponseModel({String? name}) =
      _NotificationResponseModel;

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseModelFromJson(json);
}
