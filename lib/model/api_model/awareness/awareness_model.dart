import 'package:freezed_annotation/freezed_annotation.dart';

part 'awareness_model.freezed.dart';
part 'awareness_model.g.dart';

@freezed
class AwarenessModel with _$AwarenessModel {
  const factory AwarenessModel({
    int? awarenessID,
    String? awarenessImageURL,
    String? awarenessTitle,
    String? awarenessContent,
    DateTime? createdDate,
  }) = _AwarenessModel;

  factory AwarenessModel.fromJson(Map<String, dynamic> json) =>
      _$AwarenessModelFromJson(json);
}
