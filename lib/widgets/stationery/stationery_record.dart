import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:cupertino_icons/cupertino_icons.dart";
import "package:intl/intl.dart";

Widget TitleCard({String name="hand books are very good", int quantity=8888}) => Container(
  decoration: const BoxDecoration(
    color: Colors.amberAccent,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  margin: const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 40),
  child: Row(
    children: [
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        height: 75,
        width: 75,
        // child: const Icon(
        //   CupertinoIcons.profile_circled,
        //   color: Colors.black45,
        //   size: 75.0,
        //   semanticLabel: "Profile pic of the employee",
        // ),
        child: Image.network("https://imgs.search.brave.com/dLGIAtJ1kJ7pipKESfHELwRkOKEL1sObK9O98UY4GME/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2JiLzI3/L2JkL2JiMjdiZGZk/OWE5NzhlMmEwOWFj/MmFkMWVhZDAwMmZj/LmpwZw", fit: BoxFit.contain),
      ),
      Container(
        decoration: const BoxDecoration(

        ),
        child: Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // color: Colors.white,
                ),
                width: 240,
                child: Text(
                  name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Container(
                width: 60,
                // padding: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  "$quantity",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget EssentialRow(int index, changeState, state) => GestureDetector(
  onTap: () {
    changeState(index);
  },
  child:   Container(
    margin: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
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
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: 100,
          child: const Text(
            "87",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: 100,
          child: const Text(
            "87",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black
            ),
          ),
        ),
      ],
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
        Transaction(person: "person-1-name-is-so-and-so", reference_no: "REFERENCE_NUMBER", quantity: 20),
        Transaction(),
        Transaction(person: "person", reference_no: "AFK_!@#123", quantity: 10)
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

Widget Transaction({String person="An employee or a supllier", String reference_no="A REFERENCE NUMBER", int quantity=20}) => Container(
  decoration: const BoxDecoration(
    color: Colors.white70,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
  child: Row(
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
      Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 60,
        margin: EdgeInsets.all(7),
        child: Text(
          "$quantity",
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
      ),
    ],
  ),
);
