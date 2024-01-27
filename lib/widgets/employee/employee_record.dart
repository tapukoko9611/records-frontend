import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/models/transactionItem/transactionItem.dart";
import "package:records/widgets/employee/delete_employee.dart";
import "package:records/widgets/employee/update_employee.dart";


Widget TitleCard({required String designation, required String name, String identity="identity", required BuildContext context}) => Container(
  decoration: const BoxDecoration(
    color: Colors.amberAccent,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  width: MediaQuery.of(context).size.width,
  margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
  child: Column(
    children: [
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: const Icon(
          CupertinoIcons.profile_circled,
          color: Colors.black45,
          size: 150.0,
          semanticLabel: "Profile pic of the employee",
        ),
      ),
      Row(
        children: [
          Container(
            child: Text(
              "Name :",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            width: 140,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 10, right: 10),
          ),
          Container(
            width: 230,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10, left: 2),
            child: Text(
              name,
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 3,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      Row(
        children: [
          Container(
            child: Text(
              "Identity :",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            width: 140,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 10, right: 10),
          ),
          Container(
            width: 200,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10, left: 2),
            child: Text(
              identity.trim().length==0? "identity": identity,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      Row(
        children: [
          Container(
            child: Text(
              "Designation :",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            width: 140,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 10, right: 10),
          ),
          Container(
            width: 200,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10, left: 2),
            child: Text(
              designation,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    ],
  ),
);

Widget SortButton(BuildContext context, state, changeState){
  return GestureDetector(
    onTap: () {
      changeState();
    },
    child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 15),
        padding: EdgeInsets.all(5),
        width: 170,
        decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(5))
          // boxShadow: [BoxShadow(blurRadius: 1)]
        ),
        child: Text(
          state,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        )
    ),
  );
}

Widget UpdateButton(BuildContext context, String designation, String name, String identity, String id){
  return GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (_) => UpdateEmployeeWidget(designation: designation, name: name, identity: identity, id: id));
    },
    child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 15),
        padding: EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(blurRadius: 1)]
        ),
        child: Text(
          "Update",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        )
    ),
  );
}

Widget DeleteButton(BuildContext context, String id){
  return GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (_) => DeleteEmployeeWidget(id: id)
      );
    },
    child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [BoxShadow(blurRadius: 1)]
        ),
        child: Text(
          "Delete",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),
        )
    ),
  );
}


Widget EmployeeWiseEssentialRow(changeState, date, reference, show, context) => GestureDetector(
  onTap: () {
    changeState();
  },
  child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.circle,
              color: Colors.black87,
              size: 15.0,
              semanticLabel: "Profile pic of the employee",
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                // DateFormat('d-M-y').format(date),
                date,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
      if (show==true) GestureDetector(
        onTap: () {
          showDialog(context: context, builder: (_) => AlertDialog(content: Text("Delete Transaction"),));
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.delete,
            color: Colors.black87,
            size: 20.0,
            semanticLabel: "Profile pic of the employee",
          ),
        ),
      ) else Container(),
      Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.circle,
              color: Colors.black87,
              size: 15.0,
              semanticLabel: "Profile pic of the employee",
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                // DateFormat('d-M-y').format(date),
                reference,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    ],
  ),
);

Widget EmployeeWiseTransactionItem({required BuildContext context, required TransactionItem transactionItem}) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // margin: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 270,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // color: Colors.white38,
                  ),
                  child: Text(
                    transactionItem.item!.name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: Text(transactionItem.quantity.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
              ),
            ],
          ),
          transactionItem.remarks.trim().length!=0? Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.black45)
                ),
                color: Colors.white70.withOpacity(0.58)
            ),
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: Row(
              children: [
                Container(
                  child: Text(
                      "Remarks :"
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  width: 200,
                  // alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top:10, right: 10, bottom: 10),
                  child: Text(
                    transactionItem.remarks,
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                )
              ],
            ),
          ): Container()
        ],
      ),
    );
}

Widget EmployeeWiseTransactionList(BuildContext context, List<TransactionItem> transactionItems, String remarks) => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
        children: [
          ...transactionItems.map((transactionItem) {
            return EmployeeWiseTransactionItem(context: context, transactionItem: transactionItem);
          }).toList(),
          remarks.trim().length!=0? Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Colors.black45)
              ),
              color: Colors.lightBlueAccent
            ),
            margin: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Row(
              children: [
                Container(
                  child: Text(
                      "Remarks :"
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  width: 250,
                  // alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top:10, right: 10, bottom: 10),
                  child: Text(
                      remarks,
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                )
              ],
            ),
          ): Container()
        ]
    )
);

class EmployeeWiseWidget extends StatefulWidget {
  const EmployeeWiseWidget({super.key, required this.transaction, required this.date});
  final Transaction transaction;
  // final DateTime date;
  final String date;

  @override
  State<EmployeeWiseWidget> createState() => _EmployeeWiseWidgetState();
}

class _EmployeeWiseWidgetState extends State<EmployeeWiseWidget> {

  bool show = false;
  void changeState() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.tealAccent,
      ),
      child:   Column(
        children: [
          EmployeeWiseEssentialRow(changeState, widget.date, widget.transaction.reference, show, context),
          show? EmployeeWiseTransactionList(context, widget.transaction.transactionItems!, widget.transaction.remarks?? " "): Container(),
        ],
      ),
    );
  }
}


Widget StationeryWiseEssentialRow(changeState, name, quantity, show, context) => GestureDetector(
  onTap: () {
    changeState();
  },
  child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.circle,
              color: Colors.black87,
              size: 15.0,
              semanticLabel: "Profile pic of the employee",
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                // DateFormat('d-M-y').format(date),
                name,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
      if (show==true) GestureDetector(
        onTap: () {
          showDialog(context: context, builder: (_) => AlertDialog(content: Text("Delete Transaction"),));
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.delete,
            color: Colors.black87,
            size: 20.0,
            semanticLabel: "Profile pic of the employee",
          ),
        ),
      ) else Container(),
      Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.circle,
              color: Colors.black87,
              size: 15.0,
              semanticLabel: "Profile pic of the employee",
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                // DateFormat('d-M-y').format(date),
                quantity.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    ],
  ),
);

Widget StationeryWiseTransactionItem({required BuildContext context, required Map transactionItem}) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                transactionItem["date"],
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 20, bottom: 10, left: 10, top: 10),
                child: Text(transactionItem["quantity"].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
            ),
          ],
        ),
        Row(
          children: [
            Container(
              child: Text(
                "Reference : ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10, right: 10, left: 2),
              child: Text(
                transactionItem["reference"],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        transactionItem["remarks"].trim().length!=0? Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: Colors.black45)
              ),
              color: Colors.white70.withOpacity(0.58)
          ),
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          child: Row(
            children: [
              Container(
                child: Text(
                    "Remarks :"
                ),
                padding: EdgeInsets.all(10),
              ),
              Container(
                width: 200,
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top:10, right: 10, bottom: 10),
                child: Text(
                  transactionItem["remarks"],
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              )
            ],
          ),
        ): Container()
      ],
    ),
  );
}

Widget StationeryWiseTransactionList(BuildContext context, List transactionItems) => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
        children: [
          ...transactionItems.map((transactionItem) {
            return StationeryWiseTransactionItem(context: context, transactionItem: transactionItem);
          }).toList(),
        ]
    )
);

class StationeryWiseWidget extends StatefulWidget {
  const StationeryWiseWidget({super.key, required this.transaction});

  final Map transaction;

  @override
  State<StationeryWiseWidget> createState() => _StationeryWiseWidgetState();
}

class _StationeryWiseWidgetState extends State<StationeryWiseWidget> {

  bool show = false;
  void changeState() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.tealAccent,
      ),
      child:   Column(
        children: [
          StationeryWiseEssentialRow(changeState, widget.transaction["name"], widget.transaction["quantity"], show, context),
          show? StationeryWiseTransactionList(context, widget.transaction["transactions"]): Container(),
        ],
      ),
    );
  }
}


