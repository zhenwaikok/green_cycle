import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_request_model.freezed.dart';
part 'notification_request_model.g.dart';

@freezed
class NotificationRequestModel with _$NotificationRequestModel {
  const factory NotificationRequestModel({required Message message}) =
      _NotificationRequestModel;

  factory NotificationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestModelFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    String? token,
    NotificationContent? notification,
    Map<String, String>? data,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class NotificationContent with _$NotificationContent {
  const factory NotificationContent({String? title, String? body}) =
      _NotificationContent;

  factory NotificationContent.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentFromJson(json);
}
