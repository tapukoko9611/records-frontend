import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:cupertino_icons/cupertino_icons.dart";
import "package:intl/intl.dart";
import "package:records/models/transaction/transaction.dart";

Widget EssentialRow(changeState, date) => GestureDetector(
  onTap: () {
    changeState();
  },
  child:   Container(
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
);

Widget TransactionItem({required BuildContext context, required Transaction transaction}) {
  var person;
  var type;
  var reference = transaction.reference;

  if(transaction.employee != null) {
    person = transaction.employee!.designation;
    type = "DEMAND";
  }
  else if(transaction.supplier != null){
    person = transaction.supplier!.organization;
    type = "SUPPLY";
  }
  else {
    person = "DELETED SUPLLIER";
    type = "SUPPLY";
  }
  return GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (_) {
        return TransactionDetails(context, transaction);
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
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: 270,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // color: Colors.white38,
                  ),
                  child: Text(
                    person,
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: 270,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // color: Colors.white38,
                  ),
                  child: Text(
                    reference,
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
                // Text(
                //   "${DateTime.now()}"
                // )
              ],
            ),
          ),
          type == "DEMAND" ? Container(
            // margin: const EdgeInsets.only(right: 5),
            alignment: Alignment.centerRight,
            decoration: const BoxDecoration(
              color: Colors.red,
              // color: {type},
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            width: 30,
            height: 78,
            // margin: EdgeInsets.all(7),
            // child: const Text(" ")
          ) : Container(
            // margin: const EdgeInsets.only(right: 5),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.green,
              // color: {type},
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            width: 30,
            height: 77,

            // child: const Text(" "),
          ),
        ],
      ),
    ),
  );
}

Widget TransactionList(BuildContext context, List<dynamic> transactions) => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      children: [
        ...transactions.map((transaction) {
          return TransactionItem(context: context, transaction: transaction);
        }).toList(),
      ]
    )
);

class DateWiseWidget extends StatefulWidget {
  const DateWiseWidget({super.key, required this.transactions, required this.date});
  final List<dynamic> transactions;
  // final DateTime date;
  final String date;

  @override
  State<DateWiseWidget> createState() => _DateWiseWidgetState();
}

class _DateWiseWidgetState extends State<DateWiseWidget> {

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
          EssentialRow(changeState, widget.date),
          show? TransactionList(context, widget.transactions): Container(),
        ],
      ),
    );}
}

Widget AddTransactionButton(BuildContext context, ){ // List<Stationery> stationeryList) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          // builder: (context) => AddStationeryWidget(stationeryList: stationeryList)
        builder: (context) => AlertDialog(content: Container(child: Text("Add transaction"),),)
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

Widget TransactionDetails(BuildContext context, Transaction transaction) {

  var date = transaction.date;
  var person = {};
  var type;
  var price;
  var remarks = transaction.remarks;
  var reference = transaction.reference;

  if (transaction.employee != null) {
    type = "DEMAND";
    person = {
      "detail1": transaction.employee!.designation,
      "detail2": transaction.employee!.name,
    };
    price = null;
  } else if (transaction.supplier != null) {
    type = "SUPPLY";
    person = {
      "detail1": transaction.supplier!.organization,
      "detail2": transaction.supplier!.name,
    };
    price = transaction.price;
  } else {
    type = "SUPPLY";
    person = {
      "detail1": "DELETED",
      "detail2": "DELETED",
    };
    price = transaction.price;
  }

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
                      color: Colors.yellow.withOpacity(0.2),
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.3))
                      )
                  ),
                  child: Center(
                      child: Text(
                          type,
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            type=="DEMAND"? "Designation": "Organization"
                          ),
                          Text(
                            person["detail1"]
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              "Name"
                          ),
                          Text(
                              person["detail2"]
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              "Reference no."
                          ),
                          Text(
                              reference
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                              "Date"
                          ),
                          Text(
                              DateFormat('d-M-y').format(date)
                          )
                        ],
                      ),
                      price!=null? Row(
                        children: [
                          Text(
                              "Price"
                          ),
                          Text(
                              price!.toString()
                          )
                        ],
                      ): Container(),
                      remarks.trim().length!=0? Row(
                        children: [
                          Text(
                              "Remarks"
                          ),
                          Text(
                              remarks
                          )
                        ],
                      ): Container()
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      ...transaction.transactionItems!.map((item) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Item"
                                  ),
                                  Text(
                                    item.item.name
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Quantity"
                                  ),
                                  Text(
                                    item.quantity.toString()
                                  )
                                ],
                              ),
                              item.remarks.trim().length!=0? Row(
                                children: [
                                  Text(
                                      "Remarks"
                                  ),
                                  Text(
                                      item.remarks
                                  )
                                ],
                              ): Container()
                            ],
                          ),
                        );
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
