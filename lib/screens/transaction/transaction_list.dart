import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:records/widgets/transaction/transaction_list.dart";

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {

  List<bool> _show = [false, false, false, false];

  void _changeState(int index) {
    setState(() {
      _show[index] = !_show[index];
    });
  }

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
            const SizedBox(height: 100,),
            Container(
              color: Colors.limeAccent,
              child: Column(
                children: [
                  DateWise(0, _changeState, _show),
                  DateWise(1, _changeState, _show),
                  DateWise(2, _changeState, _show),
                  DateWise(3, _changeState, _show),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
