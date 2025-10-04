// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationRequestModelImpl _$$NotificationRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationRequestModelImpl(
  message: Message.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$NotificationRequestModelImplToJson(
  _$NotificationRequestModelImpl instance,
) => <String, dynamic>{'message': instance.message};

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      token: json['token'] as String?,
      notification: json['notification'] == null
          ? null
          : NotificationContent.fromJson(
              json['notification'] as Map<String, dynamic>,
            ),
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'notification': instance.notification,
      'data': instance.data,
    };

_$NotificationContentImpl _$$NotificationContentImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationContentImpl(
  title: json['title'] as String?,
  body: json['body'] as String?,
);

Map<String, dynamic> _$$NotificationContentImplToJson(
  _$NotificationContentImpl instance,
) => <String, dynamic>{'title': instance.title, 'body': instance.body};
