import 'package:flutter/material.dart';
import 'package:records/widgets/stationery/stationery_list.dart';

class StationeryListScreen extends StatefulWidget {
  const StationeryListScreen({super.key});

  @override
  State<StationeryListScreen> createState() => _StationeryListScreenState();
}

class _StationeryListScreenState extends State<StationeryListScreen> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            children: [
              SingleItemCard(designation: "B 30", name: "EmpName", today: 20, monthly: 30, all_time: 40),
              SingleItemCard(),
              SingleItemCard(),
              SingleItemCard(designation: "B 30", name: "EmpName", today: 20, monthly: 30, all_time: 40),
              SingleItemCard(),
              SingleItemCard(),
              SingleItemCard(designation: "B 30", name: "EmpName", today: 20, monthly: 30, all_time: 40),
              SingleItemCard(),
              SingleItemCard(),
            ],
          ),
        )
    );
  }
}


