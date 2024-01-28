/*

  type:
  date:
  reference:
  employee:
    - employee designation hints * 3
  remarks:
  item list: [
    {
      item name:
        - item name hints, quantities * 3
      quantity:
      remarks:
      remove button
    }
    add button
  ]
  cancel button
  confirm button -> confirm dialog popup

*/

/*

  type:
  date:
  reference:
  supplier:
    - supplier organization hints * 3
  remarks:
  price:
  item list: [
    {
      item name:
        - item name hints, quantities * 3
      quantity:
      remarks:
      remove button
    }
    add button
  ]
  cancel button
  confirm button -> confirm dialog popup

*/


import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:intl/intl.dart";
import "package:records/blocs/transaction/transaction_bloc.dart";
import "package:records/models/skeleton/skeleton.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/widgets/transaction/transaction_list.dart";


class AddTransaction extends StatefulWidget {
  final Skeleton skeleton;
  const AddTransaction({super.key, required this.skeleton});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
