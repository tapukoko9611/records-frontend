import "package:flutter/material.dart";

Widget ItemCardRow1({String name="hand books are very good", int quantity=8888}) => Container(
  decoration: const BoxDecoration(
    color: Colors.amberAccent,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  // margin: const EdgeInsets.all(10),
  child: Row(
    children: [
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        height: 50,
        width: 50,
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

Widget EmpCardRow2(int? today, int? monthly, int? all_time) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(5),
          child: const Text(
            "50",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(5),
          child: const Text(
            "20",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
      ],
    ),
    Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(5),
          child: const Text(
            "50",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(5),
          child: const Text(
            "20",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
      ],
    ),
    Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(5),
          child: const Text(
            "50",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(5),
          child: const Text(
            "20",
            style: TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
      ],
    ),
  ],
);

Widget ItemCard(String? designation, String? name, int? today, int? monthly, int? all_time) => Column(
  children: [
    Container(
      margin: const EdgeInsets.all(10),
      child: ItemCardRow1(),
    ),
    Container(
      margin: const EdgeInsets.all(10),
      child: EmpCardRow2(today, monthly, all_time),
    ),
  ],
);

Widget SingleItemCard(
    {String designation="A 12",
      String? name,
      int? today,
      int? monthly,
      int? all_time}) => Container(
  margin: const EdgeInsets.all(10),
  decoration: const BoxDecoration(
      color: Colors.white38,
      borderRadius: BorderRadius.all(Radius.circular(10))
  ),
  child: ItemCard(designation, name, today, monthly, all_time),
);