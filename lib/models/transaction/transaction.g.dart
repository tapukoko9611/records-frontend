// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['_id'] as String,
      remarks: json['remarks'] as String? ?? "",
      reference: json['reference'] as String,
      date: DateTime.parse(json['date'] as String),
      transactionItems: (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      employee: json['employee'] == null
          ? null
          : Employee.fromJson(json['employee'] as Map<String, dynamic>),
      price: json['price'] as int?,
      supplier: json['supplier'] == null
          ? null
          : Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
      image: json['image'] as String? ??
          "https://imgs.search.brave.com/WkGgbRvE3Bry4kA8uih7yAd58h4RrkxGVYJJLvpxLX4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvOTk5/MTQ1ODE2L3Bob3Rv/L21hbi1oYW5kcy1o/b2xkaW5nLXNob3Bw/aW5nLWxpc3QtaW4t/YS1zdXBlcm1hcmtl/dC5qcGc_cz02MTJ4/NjEyJnc9MCZrPTIw/JmM9UGIwNGtSeU8w/Z2tab21OV1RJTlhS/X243M3lRdlRxbHFq/SE5WXzctT1lnST0",
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'remarks': instance.remarks,
      'image': instance.image,
      'reference': instance.reference,
      'date': instance.date.toIso8601String(),
      'transactions':
          instance.transactionItems?.map((e) => e.toJson()).toList(),
      'employee': instance.employee?.toJson(),
      'price': instance.price,
      'supplier': instance.supplier?.toJson(),
    };
