import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:intl/intl.dart";
import "package:records/blocs/employee/employee_bloc.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/widgets/employee/employee_record.dart";

import "../../models/employee/employee.dart";

class EmployeeRecordScreen extends StatefulWidget {
  final String id;

  const EmployeeRecordScreen({super.key, required this.id});

  @override
  State<EmployeeRecordScreen> createState() => _EmployeeRecordScreenState();
}

class _EmployeeRecordScreenState extends State<EmployeeRecordScreen> {

  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List<Transaction> transactionList = [];
  List<dynamic> filteredList = [];
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Employee Record");
  FocusNode focusNode = FocusNode();
  Employee? employee;

  List<String> displays = ["DEMAND WISE", "STATIONERY WISE"];
  int displayWise = 0; // employee, stationery - %2=0,1
  Widget? displayWiseWidget;
  void changeDisplayWise() {
    setState(() {
      displayWise = (displayWise+1)%2;
    });
  }

  List<String> searches = ["Date", "Reference"];
  int searchType = 0; // date, reference -%2=0,1
  Widget? searchTypeWidget;
  void changeSearchType() {
    setState(() {
      searchType = (searchType+1)%2;
    });
  }

  _EmployeeRecordScreenState() {
    _filter.addListener(() {
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = _getDateWiseList(transactionList);
          // tempWidget = AddTransactionButton(context);
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
    context.read<EmployeeBloc>().add(GetEmployeeRecord(id: widget.id));
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
          decoration:  InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search by ${searches[searchType]}"
          ),
          focusNode: focusNode,
        );
        focusNode.requestFocus();
      }
      else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text("Employee Record");
        filteredList = displayWise==0? _getDateWiseList(transactionList): _getStationeryWiseList(transactionList);
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
        focusNode.hasPrimaryFocus? IconButton(
          padding: const EdgeInsets.only(right: 20),
          onPressed: () {
            changeSearchType();
          },
          icon: searchType==0? Icon(Icons.calendar_month): Icon(Icons.tag),
          tooltip: "Search by ${searches[(searchType+1)%2]}",
        ) : Container(),
        IconButton(
          padding: const EdgeInsets.only(right: 20),
          onPressed: () {
            context.read<EmployeeBloc>().add(GetEmployeeRecord(id: widget.id));
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
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if(state is EmployeeInitial) {}
            },
            builder: (context, state) {
              print("Employee Record Screen state: ");
              print(state);
              if(state is EmployeeRecordFailure) {
                return Center(
                    child: Text("Error: ${state.error}.\n Please Reload")
                );
              }
              if(state is EmployeeDeleteSuccess) {
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                });
              }
              if(state is! EmployeeRecordLoaded) {
                return const Center(child: CircularProgressIndicator.adaptive(),);
              }

              employee =  List.from(state.employeeListWithARecord).firstWhere((employee) => employee.id == widget.id);
              print(state.employeeListWithARecord.firstWhere((employee) => employee.id == widget.id).transactions);
              transactionList = List.from(employee!.transactions);
              print(transactionList);
              transactionList.sort((a, b) => a.date.isBefore(b.date) == true? 1: 0);
              filteredList = displayWise==0? _getDateWiseList(transactionList): _getStationeryWiseList(transactionList);
              // print(_getStationeryWiseList(transactionList));
              // tempWidget = AddTransactionButton(context);

              if(_searchText.isNotEmpty) {
                if (searchType==0) {
                  filteredList = filteredList.where((item) =>
                      item["date"].contains(_searchText.toUpperCase())
                  ).toList();
                } else {
                  filteredList = filteredList.where((item) =>
                      item["reference"].contains(_searchText.toUpperCase())
                  ).toList();
                }
                // if (filteredList.isNotEmpty) {
                //   tempWidget = const SizedBox(height: 10,);
                // }
                // else {
                //   tempWidget = AddTransactionButton(context);
                // }
              }

              return GestureDetector(
                child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.hardEdge,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                        children: [
                          TitleCard(designation: employee!.designation, name: employee!.name, context: context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SortButton(context, displays[displayWise], changeDisplayWise),
                              Row(
                                children: [
                                  DeleteButton(context, employee!.id),
                                  UpdateButton(context, employee!.designation, employee!.name, employee!.identity?? " ", employee!.id)
                                ],
                              )
                            ],
                          ),
                          // tempWidget!,
                          // ...filteredList.map((dateWise) {
                          //   if(showWise==1 && dateWise["hasDemand"]==true) {
                          //     return EmployeeWiseWidget(date: dateWise["date"], transactions: dateWise["transactions"], show: showWise,);
                          //   }
                          //   else if(showWise==2 && dateWise["hasSupply"]==true) {
                          //     return EmployeeWiseWidget(date: dateWise["date"], transactions: dateWise["transactions"], show: showWise,);
                          //   }
                          //   else{
                          //     return EmployeeWiseWidget(date: dateWise["date"], transactions: dateWise["transactions"], show: showWise,);
                          //   }
                          //   // else {
                          //   //   return Container();
                          //   // }
                          // }).toList()
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
        return EmployeeWiseWidget(date: DateFormat('d-M-y').format(transaction.date), transaction: transaction);
      }).toList();
    }
    // else {
    //   return filteredList.map((dateWise) {
    //     if(showWise==1 && dateWise["hasDemand"]==true) {
    //       return StationeryWiseWidget(date: dateWise["date"], transactions: dateWise["stationery"], show: showWise,);
    //     }
    //     else if(showWise==2 && dateWise["hasSupply"]==true) {
    //       print(dateWise);
    //       return StationeryWiseWidget(date: dateWise["date"], transactions: dateWise["stationery"], show: showWise,);
    //     }
    //     else if(showWise==0){
    //       return StationeryWiseWidget(date: dateWise["date"], transactions: dateWise["stationery"], show: showWise,);
    //     }
    //     else {
    //       return Container();
    //     }
    //   }).toList();
    // }
    else return [Container()];
  }

  List<dynamic> _getDateWiseList(List<Transaction> list) {
    // var dateWiseList = [];
    // for (var transaction in list) {
    //   var date = DateFormat('d-M-y').format(transaction.date);
    //   bool hasDate = false;
    //   for (int i=0; i<dateWiseList.length; i++) {
    //     if(dateWiseList[i]!={} && dateWiseList[i]["date"] == date) {
    //       hasDate = true;
    //       dateWiseList[i]["transactions"] = [
    //         ...dateWiseList[i]["transactions"],
    //         transaction
    //       ];
    //       if(transaction.employee!=null) {
    //         dateWiseList[i]["hasDemand"] = true;
    //       }
    //       if(transaction.supplier!=null) {
    //         dateWiseList[i]["hasSupply"] = true;
    //       }
    //     }
    //   }
    //   if (!hasDate) {
    //     dateWiseList.add({
    //       "date": date,
    //       "transactions": [transaction],
    //       "hasDemand": transaction.employee!=null? true: false,
    //       "hasSupply": transaction.supplier!=null? true: false,
    //     });
    //   }
    // }
    return list;
  }

  List<dynamic> _getStationeryWiseList(List<Transaction> list) {
    var dateWiseList = [];
    for(var transaction in list) {
      var hasDate = false;
      for(int i=0; i<dateWiseList.length; i++) {
        if(dateWiseList[i]["date"] == DateFormat('d-M-y').format(transaction.date)) {
          hasDate = true;
          for(var item in transaction.transactionItems!) {
            var hasItem = false;
            for(int j=0; j<dateWiseList[i]["stationery"].length; j++) {
              if(dateWiseList[i]["stationery"][j]["name"] == item.item!.name) {
                hasItem = true;
                dateWiseList[i]["stationery"][j]["transactions"] = [
                  ...dateWiseList[i]["stationery"][j]["transactions"],
                  {
                    "person": transaction.employee!=null? transaction.employee!.designation: transaction.supplier!=null? transaction.supplier!.organization: "DELETED SUPPLIER",
                    "reference": transaction.reference,
                    "quantity": item.quantity,
                    "remarks": transaction.remarks+item.remarks
                  }
                ];
                if(item.type=="DEMAND") {
                  dateWiseList[i]["stationery"][j]["demand"] += item.quantity;
                  dateWiseList[i]["hasDemand"] = true;
                }
                else if(item.type=="SUPPLY") {
                  dateWiseList[i]["stationery"][j]["supply"] += item.quantity;
                  dateWiseList[i]["hasSupply"] = true;
                }
              }
            }
            if(hasItem==false) {
              dateWiseList[i]["stationery"].add({
                "name": item.item!.name,
                "demand": item.type=="DEMAND"? item.quantity: 0,
                "supply": item.type=="SUPPLY"? item.quantity: 0,
                "transactions": [
                  {
                    "person": transaction.employee != null
                        ? transaction.employee!.designation
                        : transaction.supplier != null
                        ? transaction.supplier!.organization
                        : "DELETED SUPPLIER",
                    "reference": transaction.reference,
                    "quantity": item.quantity,
                    "remarks": transaction.remarks + item.remarks
                  }
                ]
              });
              if(item.type=="DEMAND") {
                dateWiseList[i]["hasDemand"] = true;
              }
              else if(item.type=="SUPPLY") {
                dateWiseList[i]["hasSupply"] = true;
              }
            }
          }
        }
      }
      if(hasDate==false) {
        dateWiseList.add({
          "date": DateFormat('d-M-y').format(transaction.date),
          "hasDemand": false,
          "hasSupply": false,
          "stationery": []
        });
        var i = dateWiseList.length-1;
        for(var item in transaction.transactionItems!) {
          var hasItem = false;
          for(int j=0; j<dateWiseList[i]["stationery"].length; j++) {
            if(dateWiseList[i]["stationery"][j]["name"] == item.item!.name) {
              hasItem = true;
              dateWiseList[i]["stationery"][j]["transactions"] = [
                ...dateWiseList[i]["stationery"][j]["transactions"],
                {
                  "person": transaction.employee!=null? transaction.employee!.designation: transaction.supplier!=null? transaction.supplier!.organization: "DELETED SUPPLIER",
                  "reference": transaction.reference,
                  "quantity": item.quantity,
                  "remarks": transaction.remarks+item.remarks
                }
              ];
              if(item.type=="DEMAND") {
                dateWiseList[i]["stationery"][j]["demand"] += item.quantity;
                dateWiseList[i]["hasDemand"] = true;
              }
              else if(item.type=="SUPPLY") {
                dateWiseList[i]["stationery"][j]["supply"] += item.quantity;
                dateWiseList[i]["hasSupply"] = true;
              }
            }
          }
          if(hasItem==false) {
            dateWiseList[i]["stationery"].add({
              "name": item.item!.name,
              "demand": item.type=="DEMAND"? item.quantity: 0,
              "supply": item.type=="SUPPLY"? item.quantity: 0,
              "transactions": [{
                "person": transaction.employee!=null? transaction.employee!.designation: transaction.supplier!=null? transaction.supplier!.organization: "DELETED SUPPLIER",
                "reference": transaction.reference,
                "quantity": item.quantity,
                "remarks": transaction.remarks+item.remarks
              }]
            });
            if(item.type=="DEMAND") {
              dateWiseList[i]["hasDemand"] = true;
            }
            else if(item.type=="SUPPLY") {
              dateWiseList[i]["hasSupply"] = true;
            }
          }
        }
      }
    }
    return dateWiseList;
  }

// @override
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     physics: const ClampingScrollPhysics(),
//     scrollDirection: Axis.vertical,
//     clipBehavior: Clip.hardEdge,
//     child: Container(
//       decoration: const BoxDecoration(
//         color: Colors.teal,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         children: [
//           const SizedBox(height: 100,),
//           Container(
//             color: Colors.limeAccent,
//             child: const Column(
//               children: [
//                 DateWiseWidget(),
//                 DateWiseWidget(),
//                 DateWiseWidget(),
//                 DateWiseWidget(),
//                 DateWiseWidget(),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

}
