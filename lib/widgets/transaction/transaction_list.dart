import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/screens/transaction/add_transaction.dart";


Widget AddTransactionButton(BuildContext context, ){ // List<Stationery> stationeryList) {
  return GestureDetector(
    onTap: () {
      // showDialog(
      //     context: context,
      //     // builder: (context) => AddStationeryWidget(stationeryList: stationeryList)
      //     builder: (context) => AlertDialog(content: Container(child: Text("Add transaction"),),)
      // );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransaction(),));
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

Widget SortButton(BuildContext context, state, changeState){
  return GestureDetector(
    onTap: () {
      changeState();
    },
    child: Container(
        height: 50,
        alignment: Alignment.center,
        width: 180,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(10))
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


Widget EmployeeWiseTransactionDetails(BuildContext context, Transaction transaction) {

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
                      color: type=="DEMAND"? Colors.redAccent.shade400.withOpacity(0.4): Colors.greenAccent.shade400.withOpacity(0.4),
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.3))
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))
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
                              type=="DEMAND"? "Designation :": "Organization :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                // shadows: [Shadow(blurRadius: 2)],
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
                              person["detail1"],
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
                              person["detail2"],
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
                              "Reference no :",
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
                              reference,
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
                              DateFormat('d-M-y').format(date),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      price!=null? Row(
                        children: [
                          Container(
                            child: Text(
                              "Price :",
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
                              price!.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ): Container(),
                      remarks.trim().length!=0? Row(
                        children: [
                          Container(
                            child: Text(
                              "Remarks :",
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
                              remarks,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.fade,
                              maxLines: 7,
                              softWrap: true,
                            ),
                          )
                        ],
                      ): Container()
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: type=="DEMAND"? Colors.redAccent.shade400.withOpacity(0.2): Colors.greenAccent.shade400.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: [
                      ...transaction.transactionItems!.map((item) {
                        return Container(
                          padding: EdgeInsets.only(bottom: 7),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12)
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                        "Item :"
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
                                        item.item!.name
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
                                        item.quantity.toString()
                                    ),
                                  )
                                ],
                              ),
                              item.remarks.trim().length!=0? Row(
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
                                      item.remarks,
                                      overflow: TextOverflow.fade,
                                      maxLines: 7,
                                      softWrap: true,
                                    ),
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

Widget EmployeeWiseTransactionItem({required BuildContext context, required Transaction transaction, required int show}) {
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
  if (show==1 && type=="DEMAND") {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) {
          return EmployeeWiseTransactionDetails(context, transaction);
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
  else if (show==2 && type=="SUPPLY") {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) {
          return EmployeeWiseTransactionDetails(context, transaction);
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
  else if (show==0) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) {
          return EmployeeWiseTransactionDetails(context, transaction);
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
  else {
    return Container();
  }
}

Widget EmployeeWiseTransactionList(BuildContext context, List<dynamic> transactions, int show) => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      children: [
        ...transactions.map((transaction) {
          return EmployeeWiseTransactionItem(context: context, transaction: transaction, show: show);
        }).toList(),
      ]
    )
);

class EmployeeWiseWidget extends StatefulWidget {
  const EmployeeWiseWidget({super.key, required this.transactions, required this.date, required this.show});
  final List<dynamic> transactions;
  // final DateTime date;
  final String date;
  final int show;

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
          EssentialRow(changeState, widget.date),
          show? EmployeeWiseTransactionList(context, widget.transactions, widget.show): Container(),
        ],
      ),
    );}
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
          EssentialRow(changeState, widget.date),
          show? StationeryWiseTransactionList(context, widget.transactions, widget.show, widget.date): Container(),
        ],
      ),
    );}
}

