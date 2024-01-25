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
              identity,
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


Widget StationeryWiseTransactionDetails(BuildContext context, List<dynamic> transactions, String date, int demand, int supply, String name, String type, int show) {

  return AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -15,
            top: -15,
            width: 30,
            height: 30,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red,
                child: Icon(Icons.close, size: 18,),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 60,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    // color: type=="BOTH"? Colors.amberAccent.withOpacity(0.4): type=="DEMAND"? Colors.redAccent.withOpacity(0.4): Colors.greenAccent.withOpacity(0.4),
                      color: Colors.amberAccent.shade400.withOpacity(0.2),
                      border: Border(
                        bottom: BorderSide(
                          // color: Colors.grey.withOpacity(0.3))
                            width: 2,
                            color: Colors.black45),
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))
                  ),
                  child: Center(
                      child: Text(
                          type=="BOTH"? "TRANSACTION": type,
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontFamily: "Helvetica"
                          )
                      )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2, color: Colors.black45)
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Name :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            width: 140,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(top: 10, right: 10),
                          ),
                          Container(
                            width: 180,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 10, left: 2),
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Date :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            width: 140,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(top: 10, right: 10),
                          ),
                          Container(
                            width: 180,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 10, left: 2),
                            child: Text(
                              date,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Demand :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            width: 140,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(top: 10, right: 10),
                          ),
                          Container(
                            width: 180,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 10, left: 2),
                            child: Text(
                              demand.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "Supply :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            width: 140,
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(top: 10, right: 10),
                          ),
                          Container(
                            width: 180,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 10, left: 2),
                            child: Text(
                              supply.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.amberAccent.shade400.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: [
                      ...transactions.map((transaction) {
                        if(show==1 && transaction["quantity"]<0) return Container(
                          padding: EdgeInsets.only(bottom: 7),
                          decoration: BoxDecoration(
                            color: transaction["quantity"]<0? Colors.redAccent.shade400.withOpacity(0.2): Colors.greenAccent.shade400.withOpacity(0.2),
                            border: Border(
                                bottom: BorderSide(color: Colors.black38, width: 1),
                                top: BorderSide(color: Colors.black38, width: 1)
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        transaction["quantity"]<0? "Employee :": 'Supplier :'
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["person"]
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Reference :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["reference"]
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Quantity :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["quantity"].toString()
                                    ),
                                  )
                                ],
                              ),
                              transaction["remarks"].trim().length!=0? Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Remarks :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["remarks"]
                                    ),
                                  )
                                ],
                              ): Container()
                            ],
                          ),
                        );
                        else if(show==2 && transaction["quantity"]>0) return Container(
                          padding: EdgeInsets.only(bottom: 7),
                          decoration: BoxDecoration(
                            color: transaction["quantity"]<0? Colors.redAccent.shade400.withOpacity(0.2): Colors.greenAccent.shade400.withOpacity(0.2),
                            border: Border(
                                bottom: BorderSide(color: Colors.black38, width: 1),
                                top: BorderSide(color: Colors.black38, width: 1)
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        transaction["quantity"]<0? "Employee :": 'Supplier :'
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["person"]
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Reference :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["reference"]
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Quantity :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["quantity"].toString()
                                    ),
                                  )
                                ],
                              ),
                              transaction["remarks"].trim().length!=0? Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Remarks :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["remarks"]
                                    ),
                                  )
                                ],
                              ): Container()
                            ],
                          ),
                        );
                        else if(show==0) return Container(
                          padding: EdgeInsets.only(bottom: 7),
                          decoration: BoxDecoration(
                            color: transaction["quantity"]<0? Colors.redAccent.shade400.withOpacity(0.2): Colors.greenAccent.shade400.withOpacity(0.2),
                            border: Border(
                                bottom: BorderSide(color: Colors.black38, width: 1),
                                top: BorderSide(color: Colors.black38, width: 1)
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        transaction["quantity"]<0? "Employee :": 'Supplier :'
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["person"]
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Reference :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["reference"]
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Quantity :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["quantity"].toString()
                                    ),
                                  )
                                ],
                              ),
                              transaction["remarks"].trim().length!=0? Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Remarks :"
                                    ),
                                    width: 130,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                  ),
                                  Container(
                                    width: 160,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 10, left: 2),
                                    child: Text(
                                        transaction["remarks"]
                                    ),
                                  )
                                ],
                              ): Container()
                            ],
                          ),
                        );
                        else return Container();
                      }).toList()
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget StationeryWiseTransactionItem({required BuildContext context, required Map<String, dynamic> transaction, required int show, required String date}) {
  var type;

  if(transaction["demand"]!=0 && transaction["supply"]!=0) {
    type = "BOTH";
  }
  else if(transaction["demand"] != 0) {
    type = "DEMAND";
  }
  else{
    type = "SUPPLY";
  }

  if (show==1 && (type=="DEMAND" || type=="BOTH")) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) {
          return StationeryWiseTransactionDetails(context, transaction["transactions"], date, transaction["demand"], transaction["supply"], transaction["name"], type, show);
        });
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(

              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: 270,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // color: Colors.white38,
                ),
                child: Text(
                  transaction["name"],
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
              // margin: const EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  // color: {type},
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                width: 40,
                height: 60,

                child: Text(transaction["demand"].toString())
            ),
          ],
        ),
      ),
    );
  }
  else if (show==2 && (type=="SUPPLY" || type=="BOTH")) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) {
          return StationeryWiseTransactionDetails(context, transaction["transactions"], date, transaction["demand"], transaction["supply"], transaction["name"], type, show);
        });
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(

              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: 270,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // color: Colors.white38,
                ),
                child: Text(
                  transaction["name"],
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
              // margin: const EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  // color: {type},
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                width: 40,
                height: 60,

                child: Text(transaction["supply"].toString())
            ),
          ],
        ),
      ),
    );
  }
  else if (show==0) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) {
          return StationeryWiseTransactionDetails(context, transaction["transactions"], date, transaction["demand"], transaction["supply"], transaction["name"], type, show);
        });
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(

              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: 270,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // color: Colors.white38,
                ),
                child: Text(
                  transaction["name"],
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
            type == "BOTH"? Row(
              children: [
                Container(
                  // margin: const EdgeInsets.only(right: 5),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      // color: {type},
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    width: 40,
                    height: 60,
                    // margin: EdgeInsets.all(7),
                    child: Text(transaction["supply"].toString())
                ),
                Container(
                  // margin: const EdgeInsets.only(right: 5),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      // color: {type},
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    width: 40,
                    height: 60,
                    // margin: EdgeInsets.all(7),
                    child: Text(transaction["demand"].toString())
                ),
              ],
            ) :
            type == "DEMAND" ? Container(
              // margin: const EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  // color: {type},
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                width: 40,
                height: 60,
                // margin: EdgeInsets.all(7),
                child: Text(transaction["demand"].toString())
            ) : Container(
              // margin: const EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  // color: {type},
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                width: 40,
                height: 60,

                child: Text(transaction["supply"].toString())
            ),
          ],
        ),
      ),
    );
  }
  else {
    return Container();
  }
}

Widget StationeryWiseTransactionList(BuildContext context, List<dynamic> transactions, int show, String date) => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
        children: [
          ...transactions.map((transaction) {
            return StationeryWiseTransactionItem(context: context, transaction: transaction, show: show, date: date);
          }).toList(),
        ]
    )
);

class StationeryWiseWidget extends StatefulWidget {
  const StationeryWiseWidget({super.key, required this.transactions, required this.date, required this.show});

  final List<dynamic> transactions;
  final String date;
  final int show;

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
          EmployeeWiseEssentialRow(changeState, widget.date, widget.transactions[0]["remarks"], show, context),
          show? StationeryWiseTransactionList(context, widget.transactions, widget.show, widget.date): Container(),
        ],
      ),
    );}
}


