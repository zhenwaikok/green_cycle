// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationRequestModel _$NotificationRequestModelFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationRequestModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationRequestModel {
  Message get message => throw _privateConstructorUsedError;

  /// Serializes this NotificationRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationRequestModelCopyWith<NotificationRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRequestModelCopyWith<$Res> {
  factory $NotificationRequestModelCopyWith(
    NotificationRequestModel value,
    $Res Function(NotificationRequestModel) then,
  ) = _$NotificationRequestModelCopyWithImpl<$Res, NotificationRequestModel>;
  @useResult
  $Res call({Message message});

  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class _$NotificationRequestModelCopyWithImpl<
  $Res,
  $Val extends NotificationRequestModel
>
    implements $NotificationRequestModelCopyWith<$Res> {
  _$NotificationRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as Message,
          )
          as $Val,
    );
  }

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get message {
    return $MessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationRequestModelImplCopyWith<$Res>
    implements $NotificationRequestModelCopyWith<$Res> {
  factory _$$NotificationRequestModelImplCopyWith(
    _$NotificationRequestModelImpl value,
    $Res Function(_$NotificationRequestModelImpl) then,
  ) = __$$NotificationRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Message message});

  @override
  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$NotificationRequestModelImplCopyWithImpl<$Res>
    extends
        _$NotificationRequestModelCopyWithImpl<
          $Res,
          _$NotificationRequestModelImpl
        >
    implements _$$NotificationRequestModelImplCopyWith<$Res> {
  __$$NotificationRequestModelImplCopyWithImpl(
    _$NotificationRequestModelImpl _value,
    $Res Function(_$NotificationRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NotificationRequestModelImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as Message,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRequestModelImpl implements _NotificationRequestModel {
  const _$NotificationRequestModelImpl({required this.message});

  factory _$NotificationRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationRequestModelImplFromJson(json);

  @override
  final Message message;

  @override
  String toString() {
    return 'NotificationRequestModel(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRequestModelImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRequestModelImplCopyWith<_$NotificationRequestModelImpl>
  get copyWith =>
      __$$NotificationRequestModelImplCopyWithImpl<
        _$NotificationRequestModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRequestModelImplToJson(this);
  }
}

abstract class _NotificationRequestModel implements NotificationRequestModel {
  const factory _NotificationRequestModel({required final Message message}) =
      _$NotificationRequestModelImpl;

  factory _NotificationRequestModel.fromJson(Map<String, dynamic> json) =
      _$NotificationRequestModelImpl.fromJson;

  @override
  Message get message;

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationRequestModelImplCopyWith<_$NotificationRequestModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String? get token => throw _privateConstructorUsedError;
  NotificationContent? get notification => throw _privateConstructorUsedError;
  Map<String, String>? get data => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call({
    String? token,
    NotificationContent? notification,
    Map<String, String>? data,
  });

  $NotificationContentCopyWith<$Res>? get notification;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? notification = freezed,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
            notification: freezed == notification
                ? _value.notification
                : notification // ignore: cast_nullable_to_non_nullable
                      as NotificationContent?,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>?,
          )
          as $Val,
    );
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationContentCopyWith<$Res>? get notification {
    if (_value.notification == null) {
      return null;
    }

    return $NotificationContentCopyWith<$Res>(_value.notification!, (value) {
      return _then(_value.copyWith(notification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
    _$MessageImpl value,
    $Res Function(_$MessageImpl) then,
  ) = __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? token,
    NotificationContent? notification,
    Map<String, String>? data,
  });

  @override
  $NotificationContentCopyWith<$Res>? get notification;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
    _$MessageImpl _value,
    $Res Function(_$MessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? notification = freezed,
    Object? data = freezed,
  }) {
    return _then(
      _$MessageImpl(
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
        notification: freezed == notification
            ? _value.notification
            : notification // ignore: cast_nullable_to_non_nullable
                  as NotificationContent?,
        data: freezed == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl({
    this.token,
    this.notification,
    final Map<String, String>? data,
  }) : _data = data;

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String? token;
  @override
  final NotificationContent? notification;
  final Map<String, String>? _data;
  @override
  Map<String, String>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Message(token: $token, notification: $notification, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.notification, notification) ||
                other.notification == notification) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    token,
    notification,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(this);
  }
}

abstract class _Message implements Message {
  const factory _Message({
    final String? token,
    final NotificationContent? notification,
    final Map<String, String>? data,
  }) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String? get token;
  @override
  NotificationContent? get notification;
  @override
  Map<String, String>? get data;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationContent _$NotificationContentFromJson(Map<String, dynamic> json) {
  return _NotificationContent.fromJson(json);
}

/// @nodoc
mixin _$NotificationContent {
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;

  /// Serializes this NotificationContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationContentCopyWith<NotificationContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationContentCopyWith<$Res> {
  factory $NotificationContentCopyWith(
    NotificationContent value,
    $Res Function(NotificationContent) then,
  ) = _$NotificationContentCopyWithImpl<$Res, NotificationContent>;
  @useResult
  $Res call({String? title, String? body});
}

/// @nodoc
class _$NotificationContentCopyWithImpl<$Res, $Val extends NotificationContent>
    implements $NotificationContentCopyWith<$Res> {
  _$NotificationContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = freezed, Object? body = freezed}) {
    return _then(
      _value.copyWith(
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            body: freezed == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationContentImplCopyWith<$Res>
    implements $NotificationContentCopyWith<$Res> {
  factory _$$NotificationContentImplCopyWith(
    _$NotificationContentImpl value,
    $Res Function(_$NotificationContentImpl) then,
  ) = __$$NotificationContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? body});
}

/// @nodoc
class __$$NotificationContentImplCopyWithImpl<$Res>
    extends _$NotificationContentCopyWithImpl<$Res, _$NotificationContentImpl>
    implements _$$NotificationContentImplCopyWith<$Res> {
  __$$NotificationContentImplCopyWithImpl(
    _$NotificationContentImpl _value,
    $Res Function(_$NotificationContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = freezed, Object? body = freezed}) {
    return _then(
      _$NotificationContentImpl(
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        body: freezed == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationContentImpl implements _NotificationContent {
  const _$NotificationContentImpl({this.title, this.body});

  factory _$NotificationContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationContentImplFromJson(json);

  @override
  final String? title;
  @override
  final String? body;

  @override
  String toString() {
    return 'NotificationContent(title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationContentImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, body);

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationContentImplCopyWith<_$NotificationContentImpl> get copyWith =>
      __$$NotificationContentImplCopyWithImpl<_$NotificationContentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationContentImplToJson(this);
  }
}

abstract class _NotificationContent implements NotificationContent {
  const factory _NotificationContent({
    final String? title,
    final String? body,
  }) = _$NotificationContentImpl;

  factory _NotificationContent.fromJson(Map<String, dynamic> json) =
      _$NotificationContentImpl.fromJson;

  @override
  String? get title;
  @override
  String? get body;

  /// Create a copy of NotificationContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationContentImplCopyWith<_$NotificationContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
