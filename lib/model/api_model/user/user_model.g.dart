// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userID: json['userID'] as String?,
      userRole: json['userRole'] as String?,
      fullName: json['fullName'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] as String?,
      vehicleType: json['vehicleType'] as String?,
      vehiclePlateNumber: json['vehiclePlateNumber'] as String?,
      companyName: json['companyName'] as String?,
      profileImageURL: json['profileImageURL'] as String?,
      approvalStatus: json['approvalStatus'] as String?,
      accountRejectMessage: json['accountRejectMessage'] as String?,
      currentPoint: (json['currentPoint'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'userRole': instance.userRole,
      'fullName': instance.fullName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'gender': instance.gender,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'address1': instance.address1,
      'address2': instance.address2,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'state': instance.state,
      'vehicleType': instance.vehicleType,
      'vehiclePlateNumber': instance.vehiclePlateNumber,
      'companyName': instance.companyName,
      'profileImageURL': instance.profileImageURL,
      'approvalStatus': instance.approvalStatus,
      'accountRejectMessage': instance.accountRejectMessage,
      'currentPoint': instance.currentPoint,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
