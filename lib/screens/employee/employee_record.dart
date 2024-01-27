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
      searchType = displayWise==0? 0: 2;
    });
  }

  List<String> searches = ["Date", "Reference", "Stationery"];
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
          filteredList = displayWise==0? _getDateWiseList(transactionList): _getStationeryWiseList(transactionList);
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
              // prefixIcon: Icon(Icons.search),
              hintText: "search..." //"Search by ${searchType==0? searches[0]: searchType==1? searches[1]: searches[2]}"
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
        focusNode.hasPrimaryFocus && displayWise==0? IconButton(
          padding: const EdgeInsets.only(right: 20),
          onPressed: () {
            changeSearchType();
          },
          icon: searchType==0? Icon(Icons.calendar_month): Icon(Icons.tag),
          tooltip: "search...",
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
              // print(state.employeeListWithARecord.firstWhere((employee) => employee.id == widget.id).transactions);
              transactionList = List.from(employee!.transactions);
              transactionList.sort((a, b) => a.date.isBefore(b.date) == true? 1: 0);
              filteredList = displayWise==0? _getDateWiseList(transactionList): _getStationeryWiseList(transactionList);

              if(_searchText.isNotEmpty) {
                if (searchType==0) {
                  filteredList = filteredList.where((transaction) =>
                      DateFormat('d-M-y').format(transaction.date).contains(_searchText.toUpperCase())
                  ).toList();
                } else if (searchType==1) {
                  filteredList = filteredList.where((transaction) =>
                      transaction.reference.contains(_searchText.toUpperCase())
                  ).toList();
                } else {
                  filteredList = filteredList.where((stationery) =>
                  stationery["name"].contains(_searchText.toUpperCase())
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
                          TitleCard(designation: employee!.designation, identity: employee!.identity!, name: employee!.name, context: context),
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
    else {
      return filteredList.map((transaction) {
        return StationeryWiseWidget(transaction: transaction);
      }).toList();
    }
  }

  List<dynamic> _getDateWiseList(List<Transaction> list) {
    return list;
  }

  List<dynamic> _getStationeryWiseList(List<Transaction> list) {
    var stationeryWiseList = [];
    for(var transaction in list) {
      for(var item in transaction.transactionItems!) {
          var hasItem = false;
          for(int j=0; j<stationeryWiseList.length; j++) {
            if(stationeryWiseList[j]["name"] == item.item!.name) {
              hasItem = true;
              stationeryWiseList[j]["transactions"] = [
                ...stationeryWiseList[j]["transactions"],
                {
                  "date": DateFormat('d-M-y').format(transaction.date),
                  "reference": transaction.reference,
                  "quantity": item.quantity,
                  "remarks": "${transaction.remarks} ${item.remarks}"
                }
              ];
              stationeryWiseList[j]["quantity"] += item.quantity;
            }
          }
          if(hasItem==false) {
            stationeryWiseList.add({
              "name": item.item!.name,
              "quantity": item.quantity,
              "transactions": [
                {
                  "date": DateFormat('d-M-y').format(transaction.date),
                  "reference": transaction.reference,
                  "quantity": item.quantity,
                  "remarks": "${transaction.remarks} ${item.remarks}"
                }
              ]
            });
          }
        }
    }
    return stationeryWiseList;
  }

}
