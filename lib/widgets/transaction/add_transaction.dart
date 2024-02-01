import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:records/models/skeleton/skeleton.dart';


class PersonSelectionWidget extends StatefulWidget {
  final List<String> personList;
  final String personState;// not selected, valid, new
  final String type;
  final Function changePersonState;

  const PersonSelectionWidget({super.key, required this.personList,  required this.changePersonState, required this.personState, required this.type});

  @override
  State<PersonSelectionWidget> createState() => _PersonSelectionWidgetState();
}

class _PersonSelectionWidgetState extends State<PersonSelectionWidget> {

  final TextEditingController _filter = TextEditingController();
  // String _searchText = "";
  TextEditingController _selectedPerson = TextEditingController();
  String selectionType = "INVALID";
  List<String> filteredList = [];
  Widget? errorMessage = Container();

  _PersonSelectionWidgetState() {
    // errorMessage = Container();
    _filter.addListener(() {
      if(_filter.text.trim().length==0) {
        setState(() {
          filteredList = [];
          errorMessage = Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "INVALID SELECTION",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.redAccent
              ),
            ),
          );
          selectionType="INVALID";
        });
        widget.changePersonState("", "INVALID");
      } else {
        setState(() {
          filteredList = _filter.text.trim()==""? []: widget.personList.where((name) =>
              name.contains(_filter.text.trim().toUpperCase())
          ).toList();
        });
      }

      if(_filter.text.trim().length!=0 && _selectedPerson.text.trim().length!=0 && _selectedPerson.text.trim() != _filter.text.trim()) {
        setState(() {
          selectionType = "INVALID";
          errorMessage = widget.type == "DEMAND"? Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "INVALID SELECTION",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.redAccent
              ),
            ),
          ): Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "ADDING A NEW SUPPLIER",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.redAccent
              ),
            ),
          );
        });
        widget.changePersonState(_filter.text, "INVALID");
      }
      else if(_filter.text.trim().length!=0 && _selectedPerson.text.trim().length!=0 && _selectedPerson.text.trim() == _filter.text.trim()) {
        setState(() {
          selectionType = "VALID";
          errorMessage = Container();
        });
        widget.changePersonState(_filter.text, "VALID");
      }
      else if(widget.type=="SUPPLY") {
        widget.changePersonState(_filter.text, "INVALID");
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              // height:150,
              child:TextField(
                  controller: _filter, //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), //icon of text field
                      labelText: widget.type=="DEMAND"? "Employee Designation ": "Supplier Organization " //label text of field
                  ),
              )
                  ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: selectionType!="VALID"? filteredList.length>=3? 90: filteredList.length==2? 60: filteredList.length==1? 30: 0: 0
            ),
          ],
        ),
        Positioned(
            top: 25,
            left: 250,
            child: errorMessage!
        ),
        selectionType!="VALID"? Positioned(
          top: 68,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: filteredList.length>=3? 100: filteredList.length==2? 70: filteredList.length==1? 40: 0,
            decoration: BoxDecoration(),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: filteredList.map((name) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _filter.text = name;
                        _selectedPerson.text = name;
                        selectionType = "VALID";
                        errorMessage = Container();
                      });
                      widget.changePersonState(_filter.text, "VALID");
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 40, right: 25),
                      padding: EdgeInsets.only(left: 10, bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.blueAccent.shade700)
                        ),
                        color: Colors.grey,
                      ),
                      child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Icon(
                                  Icons.person_2_rounded,
                                  size: 13,
                                  color: Colors.greenAccent
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                name,
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ): Container(),
      ],
    );
  }
}


class ItemDetailsWidget extends StatefulWidget {

  final List<String> stationeryList;
  final String type;
  final Map itemState;
  final int itemIndex;
  final Function changeItemState;

  const ItemDetailsWidget({super.key, required this.stationeryList,  required this.changeItemState, required this.itemState, required this.itemIndex, required this.type});

  @override
  State<ItemDetailsWidget> createState() => _ItemDetailsWidgetState();
}

class _ItemDetailsWidgetState extends State<ItemDetailsWidget> {
  final TextEditingController _filter = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _price = TextEditingController();

  final TextEditingController _selectedItem = TextEditingController();
  String selectionType = "INVALID";
  List<String> filteredList = [];
  Widget? errorMessage;
  FocusNode focusNode = FocusNode();

  _ItemDetailsWidgetState() {
    _filter.addListener(() {
      if(_filter.text.trim().isEmpty) {
        setState(() {
          filteredList = [];
          errorMessage = Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "INVALID SELECTION",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.redAccent
              ),
            ),
          );
        });
        widget.changeItemState(
            widget.itemIndex,
            "UPDATE",
            {
              "item": "",
              "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
              "remarks": _remarks.text.trim(),
              "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
              "state": "INVALID"
            }
        );
      } else {
        setState(() {
          // _searchText = _filter.text;
          filteredList = _filter.text.trim()==""? []: widget.stationeryList.where((name) =>
              name.contains(_filter.text.trim().toUpperCase())
          ).toList();
        });
      }

      if(_filter.text.trim().isNotEmpty && _selectedItem.text.trim().isNotEmpty && _selectedItem.text.trim() != _filter.text.trim()) {
        setState(() {
          selectionType = "INVALID";
          errorMessage = widget.type == "DEMAND"? Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              "INVALID SELECTION",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.redAccent
              ),
            ),
          ): Container(
            padding: const EdgeInsets.all(5),
            child: const Text(
              "ADDING A NEW ITEM??",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Colors.redAccent
              ),
            ),
          );
        });
        widget.changeItemState(
            widget.itemIndex,
            "UPDATE",
            {
              "item": _filter.text.trim(),
              "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
              "remarks": _remarks.text.trim(),
              "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
              "state": "INVALID"
            }
        );
      }
      else if(_filter.text.trim().isNotEmpty && _selectedItem.text.trim().isNotEmpty && _selectedItem.text.trim() == _filter.text.trim()) {
        setState(() {
          selectionType = "SELECTED";
          errorMessage = Container();
        });
        widget.changeItemState(
            widget.itemIndex,
            "UPDATE",
            {
              "item": _selectedItem.text.trim(),
              "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
              "remarks": _remarks.text.trim(),
              "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
              "state": "SELECTED"
            }
        );
      }
    });
    _quantity.addListener(() {
      widget.changeItemState(
          widget.itemIndex,
          "UPDATE",
          {
            "item": _filter.text.trim(),
            "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
            "remarks": _remarks.text.trim(),
            "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
            "state": selectionType
          }
      );
    });
    _remarks.addListener(() {
      widget.changeItemState(
          widget.itemIndex,
          "UPDATE",
          {
            "item": _filter.text.trim(),
            "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
            "remarks": _remarks.text.trim(),
            "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
            "state": selectionType
          }
      );
    });
    _price.addListener(() {
      widget.changeItemState(
          widget.itemIndex,
          "UPDATE",
          {
            "item": _filter.text.trim(),
            "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
            "remarks": _remarks.text.trim(),
            "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
            "state": selectionType
          }
      );
    });
  }

  @override
  void initState() {
    super.initState();
    errorMessage = Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  child:TextField(
                    controller: _filter, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.notes), //icon of text field
                        labelText: "Item Name " //label text of field
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  margin: selectionType=="VALID"? EdgeInsets.all(0): filteredList.length>=3? EdgeInsets.only(top: 90): filteredList.length==2? EdgeInsets.only(top: 60): filteredList.length==1? EdgeInsets.only(top: 30): EdgeInsets.only(top: 0),
                  child:TextField(
                    controller: _remarks, //editing controller of this TextField
                    decoration: const InputDecoration(
                        icon: Icon(Icons.notes), //icon of text field
                        labelText: "Remarks " //label text of field
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(5),
                  child:Center(
                      child:TextField(
                        controller: _quantity, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(Icons.monetization_on_outlined), //icon of text field
                            labelText: "Quantity " //label text of field
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      )
                  )
              ),
              widget.type=="SUPPLY"? Container(
                  padding: EdgeInsets.all(5),
                  child:Center(
                      child:TextField(
                        controller: _price, //editing controller of this TextField
                        decoration: const InputDecoration(
                            icon: Icon(Icons.monetization_on_outlined), //icon of text field
                            labelText: "Price " //label text of field
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      )
                  )
              ): Container(),
              GestureDetector(
                onTap: () {
                  widget.changeItemState(
                      widget.itemIndex,
                      "DELETE",
                      {
                        "item": _filter.text.trim(),
                        "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
                        "remarks": _remarks.text.trim(),
                        "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
                        "state": "INVALID"
                      }
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
                    child: const Icon(Icons.delete)
                ),
              ),
            ],
          ),
          selectionType!="VALID"? Positioned(
            top: 73,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: filteredList.length>=3? 100: filteredList.length==2? 70: filteredList.length==1? 40: 0,
              decoration: BoxDecoration(),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: filteredList.map((name) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _filter.text = name;
                          _selectedItem.text = name;
                          selectionType = "VALID";
                          errorMessage = Container();
                          widget.changeItemState(
                              widget.itemIndex,
                              "UPDATE",
                              {
                                "item": _selectedItem.text.trim(),
                                "quantity": _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0,
                                "remarks": _remarks.text.trim(),
                                "price": _price.text.trim().length>0? int.parse(_price.text.trim()): 0,
                                "state": "VALID"
                              }
                          );
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 45),
                        padding: EdgeInsets.only(left: 10, bottom: 8),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.blueAccent.shade700)
                          ),
                          color: Colors.grey,
                        ),
                        child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10, top: 10),
                                child: const Icon(
                                    Icons.notes,
                                    size: 13,
                                    color: Colors.greenAccent
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ): Container(),
          Positioned(
              top: 25,
              left: 250,
              child: errorMessage!
          )
        ],
      ),
    );
  }
}


class ItemList extends StatefulWidget {
  final List<String> stationeryList;
  final Function changeListState;
  final String type;
  const ItemList({super.key, required this.stationeryList, required this.changeListState, required this.type});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  List itemList = [];
  var itemListState = "VALID";
  void changeItemState(int itemIndex, String type, Map state) {
    if (type=="DELETE") {
      setState(() {
        itemList.removeAt(itemIndex);
      });
    }
    else if(type=="UPDATE") {
      setState(() {
        itemList[itemIndex] = state;
      });
    }
    setState(() {
      itemListState = itemList.any((element) => element["state"]=="INVALID")==true? "INVALID": "VALID";
    });
    widget.changeListState(
      itemList,
      itemListState
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget addWidget = GestureDetector(
      onTap: () {
        setState(() {
          itemList.add({
            "item": "",
            "quantity": 0,
            "remarks": 0,
            "price": 0,
            "state": "INVALID"
          });
          itemListState = "INVALID";
        });
        widget.changeListState(itemList, itemListState);
      },
      child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 50,
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: const Icon(Icons.add)
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.yellowAccent.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ...itemList.asMap().entries.map((entry) {
            int itemIndex = entry.key;
            Map itemState = entry.value;

            return ItemDetailsWidget(stationeryList: widget.stationeryList, changeItemState: changeItemState, itemState: itemState, itemIndex: itemIndex, type: widget.type);
          }).toList(),
          itemList.isEmpty? addWidget:
            itemListState=="VALID"? addWidget:
                widget.type=="SUPPLY"? addWidget:
                    Container()
        ],
      ),
    );
  }
}
