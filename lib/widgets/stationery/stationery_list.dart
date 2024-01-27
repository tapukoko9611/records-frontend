import "package:flutter/material.dart";
import "package:records/models/stationery/stationery.dart";
import "package:records/screens/stationery/stationery_record.dart";
import "package:records/widgets/stationery/add_stationery.dart";

Widget ItemCardRow1(String name, int quantity, String? image) => Container(
  decoration: const BoxDecoration(
    color: Colors.amberAccent,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  child: Row(
    children: [
      // Container(
      //   decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.all(Radius.circular(50)),
      //   ),
      //   height: 50,
      //   width: 50,
      //   child: Image.network(image?? "https://imgs.search.brave.com/dLGIAtJ1kJ7pipKESfHELwRkOKEL1sObK9O98UY4GME/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2JiLzI3/L2JkL2JiMjdiZGZk/OWE5NzhlMmEwOWFj/MmFkMWVhZDAwMmZj/LmpwZw", fit: BoxFit.contain),
      // ),
      Container(
        child: Icon(
          Icons.notes,
          size: 40,
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: 240,
              child: Text(
                name,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    // fontWeight: FontWeight.w700
                ),
              ),
            ),
            Container(
              width: 60,
              alignment: Alignment.centerRight,
              child: Text(
                "$quantity",
                style: const TextStyle(
                    fontSize: 30,
                    // fontWeight: FontWeight.w500,
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

Widget ItemCardRow2(List<int> demand, List<int> supply, int quantity) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Text(
            "${demand[0]}",
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Text(
            "${supply[0]}",
            style: const TextStyle(
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
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Text(
            "${demand[1]}",
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Text(
            "${supply[1]}",
            style: const TextStyle(
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
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Text(
            "${demand[2]}",
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          ),
          width: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(5),
          child: Text(
            quantity>supply[2]+demand[2]? "${quantity-demand[2]}" :"${supply[2]}",
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black54
            ),
          ),
        ),
      ],
    ),
  ],
);

Widget ItemCard(String name, int quantity, List<int> demand, List<int> supply, String? image) => Column(
  children: [
    Container(
      margin: const EdgeInsets.all(10),
      child: ItemCardRow1(name, quantity, image),
    ),
    Container(
      margin: const EdgeInsets.all(10),
      child: ItemCardRow2(demand, supply, quantity),
    ),
  ],
);

Widget SingleItemCard({
  required String id,  required String name,
  required int quantity,
  required List<int> demand,
  required List<int> supply,
  String? image="",
  required BuildContext context}) => GestureDetector(
    onTap: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StationeryRecordScreen(id: id)));
  },
    child: Container(
    margin: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: ItemCard(name, quantity, demand, supply, image),
    ),
  );

Widget AddStationeryButton(BuildContext context, List<Stationery> stationeryList) {
  return GestureDetector(
    onTap: () {
      showDialog(
          context: context,
          builder: (context) => AddStationeryWidget(stationeryList: stationeryList)
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