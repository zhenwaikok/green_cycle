// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_message_data_model.freezed.dart';
part 'remote_message_data_model.g.dart';

@freezed
class RemoteMessageDataModel with _$RemoteMessageDataModel {
  factory RemoteMessageDataModel({
    @JsonKey(name: 'DeepLink') String? deeplink,
  }) = _RemoteMessageDataModel;

  factory RemoteMessageDataModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteMessageDataModelFromJson(json);
}
