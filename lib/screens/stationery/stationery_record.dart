import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:intl/intl.dart";
import "package:records/blocs/stationery/stationery_bloc.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/widgets/stationery/stationery_record.dart";

import "../../models/stationery/stationery.dart";

class StationeryRecordScreen extends StatefulWidget {
  final String id;

  const StationeryRecordScreen({super.key, required this.id});

  @override
  State<StationeryRecordScreen> createState() => _StationeryRecordScreenState();
}

class _StationeryRecordScreenState extends State<StationeryRecordScreen> {

  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List<Transaction> transactionList = [];
  List<dynamic> filteredList = [];
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Stationery Record");
  FocusNode focusNode = FocusNode();
  Stationery? stationery;

  List<String> displays = ["DATE WISE", "PERSON WISE"];
  int displayWise = 0;
  Widget? displayWiseWidget;
  void changeDisplayWise() {
    setState(() {
      displayWise = (displayWise+1)%2;
    });
  }

  List<String> shows = ["ALL", "DEMANDS", "SUPPLIES"];
  int showWise = 0;
  Widget? showWiseWidget;
  void changeShowWise() {
    setState(() {
      showWise = (showWise+1)%3;
    });
  }

  _StationeryRecordScreenState() {
    _filter.addListener(() {
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = displayWise==0? _getDateWiseList(transactionList): _getPersonWiseList(transactionList);
        });
      }
      else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<StationeryBloc>().add(GetStationeryRecord(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildBar(context),
        body: _buildList(context)
    );
  }

  void _searchPressed() {
    setState(() {
      if(_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
          decoration:  const InputDecoration(
              hintText: "search..."
          ),
          focusNode: focusNode,
        );
        focusNode.requestFocus();
      }
      else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text("Stationery Record");
        filteredList = displayWise==0? _getDateWiseList(transactionList): _getPersonWiseList(transactionList);
        _filter.clear();
      }
    });
  }

  AppBar _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
          onPressed: _searchPressed,
          icon: _searchIcon
      ),

      actions: [
        // focusNode.hasPrimaryFocus && displayWise==0? IconButton(
        //   padding: const EdgeInsets.only(right: 20),
        //   onPressed: () {
        //     changeSearchType();
        //   },
        //   icon: searchType==0? Icon(Icons.calendar_month): Icon(Icons.person),
        //   tooltip: "search...",
        // ) : Container(),
        IconButton(
          padding: const EdgeInsets.only(right: 20),
          onPressed: () {
            context.read<StationeryBloc>().add(GetStationeryRecord(id: widget.id));
          },
          icon: const Icon(Icons.refresh),
          tooltip: "Refresh",
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))
        ),
        child: BlocConsumer<StationeryBloc, StationeryState>(
            listener: (context, state) {
              if(state is StationeryInitial) {}
            },
            builder: (context, state) {
              print("Stationery Record Screen state: ");
              print(state);
              if(state is StationeryRecordFailure) {
                return Center(
                    child: Text("Error: ${state.error}.\n Please Reload")
                );
              }
              if(state is StationeryDeleteSuccess) {
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                });
              }
              if(state is! StationeryRecordLoaded) {
                return const Center(child: CircularProgressIndicator.adaptive(),);
              }

              stationery =  List.from(state.stationeryListWithARecord).firstWhere((stationery) => stationery.id == widget.id);
              transactionList = List.from(stationery!.transactions);
              transactionList.sort((a, b) => a.date.isBefore(b.date) == true? 1: 0);
              filteredList = displayWise==0? _getDateWiseList(transactionList): _getPersonWiseList(transactionList);

              if(_searchText.isNotEmpty) {
                if (displayWise==0) {
                  filteredList = filteredList.where((element) =>
                      element["date"].contains(_searchText.toUpperCase())
                  ).toList();
                } else {
                  filteredList = filteredList.where((element) =>
                  element["person"].contains(_searchText.toUpperCase())
                  ).toList();
                }
              }

              return GestureDetector(
                child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.hardEdge,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                        children: [
                          TitleCard(context: context, name: stationery!.name, quantity: stationery!.quantity),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DisplayButton(context, displays[displayWise], changeDisplayWise),
                              Row(
                                children: [
                                  DeleteButton(context, stationery!.id),
                                  UpdateButton(context, stationery!.name, stationery!.quantity, stationery!.image?? " ", stationery!.id)
                                ],
                              )
                            ],
                          ),
                          ..._buildListBody(context, filteredList)
                        ]
                    )
                ),
              );
            }
        )
    );
  }

  List _buildListBody(BuildContext context, List filteredList) {
    if(displayWise==0) {
      return filteredList.map((transaction) {
        return DateWiseWidget(transaction: transaction);
      }).toList();
    }
    else {
      return filteredList.map((transaction) {
        return PersonWiseWidget(transaction: transaction);
      }).toList();
    }
  }

  List<dynamic> _getDateWiseList(List<Transaction> list) {
    var dateWiseList = [];
    for(var transaction in list) {
      var hasDate = false;
      for(int i=0; i<dateWiseList.length; i++) {
        if(dateWiseList[i]["date"] == DateFormat('d-M-y').format(transaction.date)) {
          hasDate = true;
          var item = transaction.transactionItems![0];
          dateWiseList[i]["transactions"] = [
            ...dateWiseList[i]["transactions"],
            {
              "person": transaction.employee!=null? transaction.employee!.designation: transaction.supplier!=null? transaction.supplier!.organization: "DELETED SUPPLIER",
              "reference": transaction.reference,
              "quantity": item.quantity,
              "remarks": "${transaction.remarks} ${item.remarks}"
            }
          ];
          if(item.type=="DEMAND") {
            dateWiseList[i]["demand"] += item.quantity;
          }
          else if(item.type=="SUPPLY") {
            dateWiseList[i]["supply"] += item.quantity;
          }
        }
      }
      if(hasDate==false) {
        var item = transaction.transactionItems![0];
        dateWiseList.add({
          "date": DateFormat('d-M-y').format(transaction.date),
          "demand": item.type=="DEMAND"? item.quantity: 0,
          "supply": item.type=="SUPPLY"? item.quantity: 0,
          "transactions": [
            {
              "person": transaction.employee!=null? transaction.employee!.designation: transaction.supplier!=null? transaction.supplier!.organization: "DELETED SUPPLIER",
              "reference": transaction.reference,
              "quantity": item.quantity,
              "remarks": "${transaction.remarks} ${item.remarks}"
            }
          ]
        });
      }
    }
    return dateWiseList;
  }

  List<dynamic> _getPersonWiseList(List<Transaction> list) {
    var personWiseList = [];
    for (var transaction in list) {
      var hasPerson = false;
      for (var i=0; i<personWiseList.length; i++) {
        if((transaction.employee!=null && personWiseList[i]["person"] == transaction.employee!.designation && personWiseList[i]["type"] == 'EMPLOYEE')||(transaction.supplier!=null && personWiseList[i]["person"] == transaction.supplier!.organization && personWiseList[i]["type"] == 'SUPPLIER') ) {
          hasPerson = true;
          personWiseList[i]["transactions"] = [
            ...personWiseList[i]["transactions"],
            {
              "date": DateFormat('d-M-y').format(transaction.date),
              "reference": transaction.reference,
              "remarks": "${transaction.remarks} ${transaction.transactionItems![0].remarks}",
              "quantity": transaction.transactionItems![0].quantity
            }
          ];
          personWiseList[i]["quantity"] += transaction.transactionItems![0].quantity;
        }
      }
      if(hasPerson==false) {
        personWiseList.add({
          "person": transaction.employee!=null? transaction.employee!.designation: transaction.supplier!=null? transaction.supplier!.organization: 'DELETED SUPPLIER',
          "type": transaction.employee!=null? "EMPLOYEE": "SUPPLIER",
          "quantity": transaction.transactionItems![0].quantity,
          "transactions": [
            {
              "date": DateFormat('d-M-y').format(transaction.date),
              "reference": transaction.reference,
              "remarks": "${transaction.remarks} ${transaction.transactionItems![0].remarks}",
              "quantity": transaction.transactionItems![0].quantity
            }
          ]
        });
      }
    }
    print("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
    print(personWiseList);
    return personWiseList;
  }


/*
  [{
    employee
    supplier
    reference
    date
    remarks
    transactions: [{
      remarks
      item
      quantity
    }]
  }]

  [{
    date
    demand
    supply
    transactions: [{
      person
      quantity
      reference
      remarks
    }]
  }]
   */

  // List<dynamic> _getStationeryWiseList(List<Transaction> list) {
  //   var stationeryWiseList = [];
  //   for(var transaction in list) {
  //     for(var item in transaction.transactionItems!) {
  //         var hasItem = false;
  //         for(int j=0; j<stationeryWiseList.length; j++) {
  //           if(stationeryWiseList[j]["name"] == item.item!.name) {
  //             hasItem = true;
  //             stationeryWiseList[j]["transactions"] = [
  //               ...stationeryWiseList[j]["transactions"],
  //               {
  //                 "date": DateFormat('d-M-y').format(transaction.date),
  //                 "reference": transaction.reference,
  //                 "quantity": item.quantity,
  //                 "remarks": "${transaction.remarks} ${item.remarks}"
  //               }
  //             ];
  //             stationeryWiseList[j]["quantity"] += item.quantity;
  //           }
  //         }
  //         if(hasItem==false) {
  //           stationeryWiseList.add({
  //             "name": item.item!.name,
  //             "quantity": item.quantity,
  //             "transactions": [
  //               {
  //                 "date": DateFormat('d-M-y').format(transaction.date),
  //                 "reference": transaction.reference,
  //                 "quantity": item.quantity,
  //                 "remarks": "${transaction.remarks} ${item.remarks}"
  //               }
  //             ]
  //           });
  //         }
  //       }
  //   }
  //   return stationeryWiseList;
  // }

}
