import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:cupertino_icons/cupertino_icons.dart";
import "package:intl/intl.dart";

Widget TitleCard({String designation="A-12", String name="EmployeeNameIsSoAndSoadsfasfsf"}) => Container(
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
        child: const Icon(
          CupertinoIcons.profile_circled,
          color: Colors.black45,
          size: 75.0,
          semanticLabel: "Profile pic of the employee",
        ),
      ),
      Container(
        decoration: const BoxDecoration(

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // color: Colors.white,
              ),
              child: Text(
                designation,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // color: Colors.white38,
              ),
              child: Text(
                name,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
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
    ],
  ),
);


Widget EssentialRow() => Container(
  margin: const EdgeInsets.all(10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.circle,
              color: Colors.black45,
              size: 15.0,
              semanticLabel: "Profile pic of the employee",
            ),
            Container(
              width: 180,
              child: const Text(
                "REFERENCE_NUMBER_00012234",
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Colors.black45,
              size: 15.0,
              semanticLabel: "Date",
            ),
            Container(
              child: Text(
                "${DateFormat('d-M-y').format(DateTime.now())}",
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

Widget Item({String name="item name", int quantity=10}) => Container(
  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
  decoration: const BoxDecoration(
    color: Colors.lightBlueAccent,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.circle,
              color: Colors.black45,
              size: 12.0,
              semanticLabel: "Profile pic of the employee",
            ),
            Container(
              width: 180,
              child: Text(
                name,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              child: Text(
                "$quantity",
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
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

Widget ItemList() => Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(
      children: [
        Item(name: "item-1-name-is-so-and-so", quantity: 20),
        Item(),
        Item(name: "item3", quantity: 15)
      ],
    )
);


class TransactionListWidget extends StatefulWidget {
  const TransactionListWidget({super.key});

  @override
  State<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {

  bool showList = false;
  Widget list = Container();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(context: context, builder: (_) => AlertDialog(
          content: Text("Long Pressed"),
        ));
      },
      onTap: () {
        if(showList) {
          setState(() {
            showList = false;
            list = ItemList();
          });
        }
        else {
          setState(() {
            showList = true;
            list = Container();
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.pinkAccent,
        ),
        child: Column(
          children: [
            EssentialRow(),
            list
          ],
        ),
      ),
    );
  }
}
