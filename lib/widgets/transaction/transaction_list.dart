import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:cupertino_icons/cupertino_icons.dart";
import "package:intl/intl.dart";

Widget EssentialRow(int index, changeState, state) => GestureDetector(
  onTap: () {
    changeState(index);
  },
  child:   Container(
    padding: const EdgeInsets.all(10),
    child: Expanded(
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.circle,
            color: Colors.black45,
            size: 15.0,
            semanticLabel: "Profile pic of the employee",
          ),
          Container(
            child: Text(
              DateFormat('d-M-y').format(DateTime.now()),
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
  ),
);

Widget TransactionList() => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      children: [
        Transaction(person: "person-1-name-is-so-and-so", reference_no: "REFERENCE_NUMBER", type: "DEMAND"),
        Transaction(),
        Transaction(person: "person", reference_no: "AFK_!@#123", type: "SUPPLY")
      ],
    )
);

Widget DateWise(int index, changeState, state) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.tealAccent,
    ),
    child:   Column(
      children: [
        EssentialRow(index, changeState, state),
        state[index]? TransactionList(): Container(),
      ],

    ),
  );}

Widget Transaction({String person="An employee or a supllier", String reference_no="A REFERENCE NUMBER", String type="DEMAND"}) => Container(
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
        child: Expanded(
          flex: 1,
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
                      fontWeight: FontWeight.w400
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
                  reference_no,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
              // Text(
              //   "${DateTime.now()}"
              // )
            ],
          ),
        ),
      ),
      type=="DEMAND"? Container(
        margin: const EdgeInsets.only(right: 5),
        alignment: Alignment.centerRight,
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          // color: {type},
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 20,
        // margin: EdgeInsets.all(7),
        child: const Text(" ")
      ): Container(
        margin: const EdgeInsets.only(right: 5),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.greenAccent,
          // color: {type},
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 20,
        // margin: EdgeInsets.all(7),
        child: const Text(" ")
      ),
    ],
  ),
);
