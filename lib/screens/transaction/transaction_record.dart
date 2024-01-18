import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:records/widgets/transaction/transaction_record.dart";

class TransactionRecordScreen extends StatefulWidget {
  const TransactionRecordScreen({super.key});

  @override
  State<TransactionRecordScreen> createState() => _TransactionRecordScreenState();
}

class _TransactionRecordScreenState extends State<TransactionRecordScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 50),
              child: const Text(
                "Employee name",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Transaction(),
          ],
        ),
      ),
    );
  }
}
