import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:records/widgets/employee/employee_record.dart";

class EmployeeRecordScreen extends StatefulWidget {
  const EmployeeRecordScreen({super.key});

  @override
  State<EmployeeRecordScreen> createState() => _EmployeeRecordScreenState();
}

class _EmployeeRecordScreenState extends State<EmployeeRecordScreen> {

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
            TitleCard(),
            Container(
              color: Colors.limeAccent,
              child: Column(
                children: [
                  Transactions(0, _changeState, _show),
                  Transactions(1, _changeState, _show),
                  Transactions(2, _changeState, _show),
                  Transactions(3, _changeState, _show),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
