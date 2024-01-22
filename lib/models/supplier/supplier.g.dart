// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supplier _$SupplierFromJson(Map<String, dynamic> json) => Supplier(
      id: json['_id'] as String,
      name: json['name'] as String,
      organization: json['organization'] as String,
      count: (json['count'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [0, 0, 0],
      identity: json['identity'] as String?,
    );

Map<String, dynamic> _$SupplierToJson(Supplier instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'organization': instance.organization,
      'identity': instance.identity,
      'count': instance.count,
    };
