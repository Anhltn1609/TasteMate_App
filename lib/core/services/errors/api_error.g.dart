// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiErrorImpl _$$ApiErrorImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorImpl(
      message: json['message'] as String?,
      code: $enumDecodeNullable(_$ErrorCodeEnumMap, json['code']),
    );

Map<String, dynamic> _$$ApiErrorImplToJson(_$ApiErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': _$ErrorCodeEnumMap[instance.code],
    };

const _$ErrorCodeEnumMap = {
  ErrorCode.dioException: 1,
  ErrorCode.errorFoo: 2,
  ErrorCode.errorBar: 3,
  ErrorCode.serverNotHappy: 6969,
  ErrorCode.unknown: null,
};
