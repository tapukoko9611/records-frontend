import "package:flutter/material.dart";
import "package:records/models/employee/employee.dart";
import "package:records/widgets/employee/add_employee.dart";

Widget EmpCardRow1(String designation, String name, String? identity) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Container(
      width: 200,
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        designation??= "A-12",
        style: const TextStyle(
            color: Colors.black,
            fontSize: 30
        ),
      ),
    ),
    Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
            name ??= 'EmployeeNameIsSoAndSo',
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
            )
        ),
      ),
    )
  ],
);

Widget EmpCardRow2(int today, int monthly, int all_time) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Container(
      decoration: const BoxDecoration(
        color: Colors.lightGreenAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        "today ${today?? 12}",
        style: const TextStyle(
            fontSize: 15,
            color: Colors.black45
        ),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        "monthly ${monthly?? 15}",
        style: const TextStyle(
            fontSize: 15,
            color: Colors.black45
        ),
      ),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        "all time ${all_time?? 18}",
        style: const TextStyle(
            fontSize: 15,
            color: Colors.black45
        ),
      ),
    ),
  ],
);

Widget EmpCard(String designation, String name, int today, int monthly, int all_time, String? identity) => Column(
  children: [
    Container(
      margin: const EdgeInsets.all(10),
      child: EmpCardRow1(designation, name, identity),
    ),
    Container(
      margin: const EdgeInsets.all(10),
      child: EmpCardRow2(today, monthly, all_time),
    ),
  ],
);

Widget SingleEmpCard(
    {required String designation,
      required String name,
      required int today,
      required int monthly,
      required int all_time,
    String? identity=""}) => Container(
  margin: const EdgeInsets.all(10),
  decoration: const BoxDecoration(
      color: Colors.white38,
      borderRadius: BorderRadius.all(Radius.circular(10))
  ),
  child: EmpCard(designation, name, today, monthly, all_time, identity),
);

Widget AddEmployeeButton(BuildContext context, List<Employee> employeeList) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (context) => AddEmployeeWidget(employeeList: employeeList)
      );
    },
    child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 50,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white38,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: const Icon(Icons.add)
    ),
  );
}