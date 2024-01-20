// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stationery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stationery _$StationeryFromJson(Map<String, dynamic> json) => Stationery(
      id: json['_id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      image: json['image'] as String? ??
          'https://imgs.search.brave.com/zXRp6Z2JMNEagn7FTUoCDRJhYMEagoduO18HCxwuRDI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA0Lzk0LzkxLzA3/LzM2MF9GXzQ5NDkx/MDc2OF85a1I5V1Zw/ZVk0bGlGRmNwUVpW/QnplN3ZvcWZNMFFF/Vy5qcGc',
      demand: (json['demand'] as List<dynamic>).map((e) => e as int).toList(),
      supply: (json['supply'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$StationeryToJson(Stationery instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'demand': instance.demand,
      'supply': instance.supply,
      'image': instance.image,
    };
