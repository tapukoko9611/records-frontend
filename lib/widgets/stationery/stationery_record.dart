import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/models/transactionItem/transactionItem.dart";
import "package:records/widgets/stationery/delete_stationery.dart";
import "package:records/widgets/stationery/update_stationery.dart";


Widget TitleCard({required String name, required int quantity, String image = " ", required BuildContext context}) => Container(
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
          Icons.notes,
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
              "Quantity: ",
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
              quantity.toString(),
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

Widget DisplayButton(BuildContext context, state, changeState){
  return GestureDetector(
    onTap: () {
      changeState();
    },
    child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 15),
        padding: EdgeInsets.all(5),
        width: 140,
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

Widget UpdateButton(BuildContext context, String name, int quantity, String image, String id){
  return GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (_) => UpdateStationeryWidget(name: name, quantity: quantity, image: image, id: id));
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

Widget DeleteButton(BuildContext context, String id) {
  return GestureDetector(
    onTap: () {
      showDialog(context: context, builder: (_) => DeleteStationeryWidget(id: id)
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


Widget PersonWiseEssentialRow(changeState, quantity, person, type, show, context) => GestureDetector(
  onTap: () {
    changeState();
  },
  child:  Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                // color: Colors.black87,
                color: type=="EMPLOYEE"? Colors.redAccent: Colors.greenAccent,
                size: 15.0,
                semanticLabel: "Profile pic of the employee",
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  // DateFormat('d-M-y').format(date),
                  person,
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
            // padding: EdgeInsets.all(15),
            child: Icon(
              Icons.delete,
              color: Colors.black87,
              size: 20.0,
              semanticLabel: "Profile pic of the employee",
            ),
          ),
        ) else Container(),
        Container(
          margin: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Icon(
                Icons.circle,
                color: type=="EMPLOYEE"? Colors.redAccent: Colors.greenAccent,
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
  ),
);

Widget PersonWiseTransactionItem({required BuildContext context, required Map transaction}) {
    return Container(
      decoration: BoxDecoration(
        color: transaction["quantity"]<0? Colors.redAccent.shade400.withOpacity(0.4): Colors.greenAccent.shade400.withOpacity(0.4),
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
                  transaction["date"],
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
                  child: Text(transaction["quantity"].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
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
                  transaction["reference"],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          transaction["remarks"].trim().length!=0? Container(
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
                    transaction["remarks"],
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

Widget PersonWiseTransactionList(BuildContext context, List transactions, String type) => Container(
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 5),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
        children: [
          ...transactions.map((transaction) {
            return PersonWiseTransactionItem(context: context, transaction: transaction);
          }).toList(),
        ]
    )
);

class PersonWiseWidget extends StatefulWidget {
  const PersonWiseWidget({super.key, required this.transaction});
  final Map transaction;

  @override
  State<PersonWiseWidget> createState() => _PersonWiseWidgetState();
}

class _PersonWiseWidgetState extends State<PersonWiseWidget> {

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
          PersonWiseEssentialRow(changeState, widget.transaction["quantity"], widget.transaction["person"], widget.transaction["type"], show, context),
          show? PersonWiseTransactionList(context, widget.transaction["transactions"], widget.transaction["type"]): Container(),
        ],
      ),
    );
  }
}


Widget DateWiseEssentialRow(changeState, date, demand, supply, transactions, show, context) {
  var type;
  if(demand!=0 && supply!=0) {
    type = "BOTH";
  } else if(demand != 0) {
    type = "DEMAND";
  } else{
    type = "SUPPLY";
  }

  return GestureDetector(
    onTap: () {
      changeState();
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Container(
        //   decoration: const BoxDecoration(
        //
        //   ),
        //   margin: const EdgeInsets.only(bottom: 10, top: 5),
        //   child: Container(
        //     padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
        //     // width: 270,
        //     decoration: const BoxDecoration(
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //       // color: Colors.white38,
        //     ),
        //     child: Text(
        //       date,
        //       overflow: TextOverflow.fade,
        //       maxLines: 1,
        //       softWrap: false,
        //       style: const TextStyle(
        //           color: Colors.black,
        //           fontSize: 15,
        //           fontWeight: FontWeight.w500
        //       ),
        //     ),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.circle,
                color: Colors.black87,
                size: 15.0,
                semanticLabel: "Profile pic of the employee",
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
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
        type == "BOTH"? Row(
          children: [
            Container(
              // margin: const EdgeInsets.only(right: 5),
              //   alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.greenAccent.shade200,
                  // color: {type},
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                // width: 40,
                // height: 60,
                // margin: EdgeInsets.all(5),
                // margin: EdgeInsets.only(top: 5, right: 5),
                padding: EdgeInsets.all(5),
                child: Text(supply.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),)
            ),
            Container(
              // margin: const EdgeInsets.only(right: 5),
              //   alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade200,
                  // color: {type},
                    borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                // width: 40,
                // height: 60,
                margin: EdgeInsets.all(5),
                // margin: EdgeInsets.only(top: 5, right: 5),
                padding: EdgeInsets.all(5),
                child: Text(demand.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),)
            ),
          ],
        ) :
        type == "DEMAND" ? Container(
          // margin: const EdgeInsets.only(right: 5),
          //   alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.redAccent.shade200,
              // color: {type},
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            // width: 40,
            // height: 60,
            margin: EdgeInsets.all(5),
            // margin: EdgeInsets.only(top: 5, right: 5),
            padding: EdgeInsets.all(5),
            child: Text(demand.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
              ),)
        ) : Container(
          // margin: const EdgeInsets.only(right: 5),
          //   alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade200,
              // color: {type},
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            // width: 40,
            // height: 60,
            margin: EdgeInsets.all(5),
            // margin: EdgeInsets.only(top: 5, right: 5),
            padding: EdgeInsets.all(5),
            child: Text(supply.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
              ),)
        ),
      ],
    ),
  );
}

Widget DateWiseTransactionItem({required BuildContext context, required Map transaction}) {
  return Container(
    decoration: BoxDecoration(
      color: transaction["quantity"]<0? Colors.redAccent.shade400.withOpacity(0.4): Colors.greenAccent.shade400.withOpacity(0.4),
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
                transaction["person"],
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
                child: Text(transaction["quantity"].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),)
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
                transaction["reference"],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        transaction["remarks"].trim().length!=0? Container(
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
                  transaction["remarks"],
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

Widget DateWiseTransactionList(BuildContext context, List transactions) => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
        children: [
          ...transactions.map((transaction) {
            return DateWiseTransactionItem(context: context, transaction: transaction);
          }).toList(),
        ]
    )
);

class DateWiseWidget extends StatefulWidget {
  const DateWiseWidget({super.key, required this.transaction});

  final Map transaction;

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
          DateWiseEssentialRow(changeState, widget.transaction["date"], widget.transaction["demand"], widget.transaction["supply"], widget.transaction["transactions"], show, context),
          show? DateWiseTransactionList(context, widget.transaction["transactions"]): Container(),
        ],
      ),
    );
  }
}


