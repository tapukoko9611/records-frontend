import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:records/widgets/stationery/stationery_record.dart";

class StationeryRecordScreen extends StatefulWidget {
  const StationeryRecordScreen({super.key});

  @override
  State<StationeryRecordScreen> createState() => _StationeryRecordScreenState();
}

class _StationeryRecordScreenState extends State<StationeryRecordScreen> {

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
