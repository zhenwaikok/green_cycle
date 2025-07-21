import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? userID,
    String? userRole,
    String? fullName,
    String? firstName,
    String? lastName,
    String? emailAddress,
    String? gender,
    String? phoneNumber,
    String? password,
    String? address,
    String? vehicleType,
    String? vehiclePlateNumber,
    String? companyName,
    String? profileImageURL,
    bool? isApproved,
    DateTime? createdDate,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
