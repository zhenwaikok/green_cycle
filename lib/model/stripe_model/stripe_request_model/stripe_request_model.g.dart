// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StripeRequestModelImpl _$$StripeRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$StripeRequestModelImpl(
  amount: (json['amount'] as num?)?.toInt(),
  currency: json['currency'] as String?,
);

Map<String, dynamic> _$$StripeRequestModelImplToJson(
  _$StripeRequestModelImpl instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency': instance.currency,
};
