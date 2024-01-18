// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['_id'] as String,
      name: json['name'] as String,
      designation: json['designation'] as String,
      count: (json['count'] as List<dynamic>).map((e) => e as int).toList(),
      identity: json['identity'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'designation': instance.designation,
      'identity': instance.identity,
      'count': instance.count,
    };
