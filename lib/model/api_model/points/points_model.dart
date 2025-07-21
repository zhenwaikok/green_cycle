import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_model.freezed.dart';
part 'points_model.g.dart';

@freezed
class PointsModel with _$PointsModel {
  const factory PointsModel({
    int? pointID,
    String? userID,
    int? point,
    String? type,
    String? description,
    DateTime? createdAt,
  }) = _PointsModel;

  factory PointsModel.fromJson(Map<String, dynamic> json) =>
      _$PointsModelFromJson(json);
}
