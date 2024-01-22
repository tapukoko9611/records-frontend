import "package:json_annotation/json_annotation.dart";

import "package:records/models/transactionItem/transactionItem.dart";
import "package:records/models/employee/employee.dart";
import "package:records/models/supplier/supplier.dart";

part "transaction.g.dart";

@JsonSerializable(explicitToJson: true)
class Transaction {

  @JsonKey(name: "_id")
  String id;
  
  // @JsonKey(defaultValue: " ")
  String remarks;
  String image;

  String reference;
  DateTime date;
  @JsonKey(name: "transactions")
  List<TransactionItem>? transactionItems;

  Employee? employee;

  int? price;
  Supplier? supplier;

  Transaction({
    required this.id,
    this.remarks = "",
    required this.reference,
    required this.date,
    this.transactionItems,
    this.employee,
    this.price,
    this.supplier,
    this.image="https://imgs.search.brave.com/WkGgbRvE3Bry4kA8uih7yAd58h4RrkxGVYJJLvpxLX4/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvOTk5/MTQ1ODE2L3Bob3Rv/L21hbi1oYW5kcy1o/b2xkaW5nLXNob3Bw/aW5nLWxpc3QtaW4t/YS1zdXBlcm1hcmtl/dC5qcGc_cz02MTJ4/NjEyJnc9MCZrPTIw/JmM9UGIwNGtSeU8w/Z2tab21OV1RJTlhS/X243M3lRdlRxbHFq/SE5WXzctT1lnST0"
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}