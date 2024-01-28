import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:intl/intl.dart";
import "package:records/blocs/transaction/transaction_bloc.dart";
import "package:records/models/skeleton/skeleton.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/widgets/transaction/transaction_list.dart";

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {

  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  Skeleton skeleton = Skeleton();
  List<Transaction>? transactionList;
  List<dynamic>? filteredList;
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Transaction List");
  FocusNode focusNode = FocusNode();

  Widget? tempWidget;

  List<String> displays = ["PERSON WISE", "STATIONERY WISE"];
  int displayWise = 0; // employee, stationery - %2=0,1
  // Widget? displayWiseWidget;
  void changeDisplayWise() {
    setState(() {
      displayWise = (displayWise+1)%2;
    });
  }

  List<String> shows = ["ALL", "DEMANDS", "SUPPLIES"];
  int showWise = 0; // all, demand, supply - %3=0,1,2
  // Widget? showWiseWidget;
  void changeShowWise() {
    setState(() {
      showWise = (showWise+1)%3;
    });
  }


  _TransactionListScreenState() {
    _filter.addListener(() {
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = _getEmployeeWiseList(transactionList!);
          tempWidget = AddTransactionButton(context);
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
    context.read<TransactionBloc>().add(FetchTransactionList());
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
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search..."
          ),
          focusNode: focusNode,
        );
        focusNode.requestFocus();
      }
      else {
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text("Transaction List");
        filteredList = displayWise==0? _getEmployeeWiseList(transactionList!): _getStationeryWiseList(transactionList!);
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
        IconButton(
          padding: const EdgeInsets.only(right: 20),
          onPressed: () {
            context.read<TransactionBloc>().add(FetchTransactionList());
          },
          icon: const Icon(Icons.refresh),
          tooltip: "Refresh",
        )
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
        child: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if(state is TransactionInitial) {}
            },
            builder: (context, state) {
              if(state is TransactionListFailure) {
                return Center(
                    child: Text("Error: ${state.error}.\n Please Reload")
                );
              }

              if(state is! TransactionListLoaded) {
                return const Center(child: CircularProgressIndicator.adaptive(),);
              }

              skeleton = state.skeleton;
              transactionList =  skeleton!.transactions;
              transactionList!.sort((a, b) => a.date.isBefore(b.date) == true? 1: 0);
              filteredList = displayWise==0? _getEmployeeWiseList(transactionList!): _getStationeryWiseList(transactionList!);
              // print(_getStationeryWiseList(transactionList));
              tempWidget = AddTransactionButton(context);

              if(_searchText.isNotEmpty) {
                filteredList = filteredList!.where((item) =>
                    item["date"].contains(_searchText.toUpperCase())
                ).toList();
                if (filteredList!.isNotEmpty) {
                  tempWidget = const SizedBox(height: 10,);
                }
                else {
                  tempWidget = AddTransactionButton(context);
                }
              }

              return GestureDetector
                (
                child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.hardEdge,
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SortButton(context, displays[displayWise], changeDisplayWise),
                              SortButton(context, shows[showWise], changeShowWise),
                            ],
                          ),
                          tempWidget!,
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
                          ..._buildListBody(context, filteredList!)
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
      return filteredList.map((dateWise) {
        if(showWise==1 && dateWise["hasDemand"]==true) {
          return EmployeeWiseWidget(date: dateWise["date"], transactions: dateWise["transactions"], show: showWise,);
        }
        else if(showWise==2 &&
            dateWise["hasSupply"]==true) {
          return EmployeeWiseWidget(date: dateWise["date"], transactions: dateWise["transactions"], show: showWise,);
        }
        else if(showWise==0){
          return EmployeeWiseWidget(date: dateWise["date"], transactions: dateWise["transactions"], show: showWise,);
        }
        else {
          return Container();
        }
      }).toList();
    }
    else {
      return filteredList.map((dateWise) {
        if(showWise==1 && dateWise["hasDemand"]==true) {
          return StationeryWiseWidget(date: dateWise["date"], transactions: dateWise["stationery"], show: showWise,);
        }
        else if(showWise==2 && dateWise["hasSupply"]==true) {
          print(dateWise);
          return StationeryWiseWidget(date: dateWise["date"], transactions: dateWise["stationery"], show: showWise,);
        }
        else if(showWise==0){
          return StationeryWiseWidget(date: dateWise["date"], transactions: dateWise["stationery"], show: showWise,);
        }
        else {
          return Container();
        }
      }).toList();
    }
  }

  List<dynamic> _getEmployeeWiseList(List<Transaction> list) {
    var dateWiseList = [];
    for (var transaction in list) {
      var date = DateFormat('d-M-y').format(transaction.date);
      bool hasDate = false;
      for (int i=0; i<dateWiseList.length; i++) {
        if(dateWiseList[i]!={} && dateWiseList[i]["date"] == date) {
          hasDate = true;
          dateWiseList[i]["transactions"] = [
            ...dateWiseList[i]["transactions"],
            transaction
          ];
          if(transaction.employee!=null) {
            dateWiseList[i]["hasDemand"] = true;
          }
          if(transaction.supplier!=null) {
            dateWiseList[i]["hasSupply"] = true;
          }
        }
      }
      if (!hasDate) {
        dateWiseList.add({
          "date": date,
          "transactions": [transaction],
          "hasDemand": transaction.employee!=null? true: false,
          "hasSupply": transaction.supplier!=null? true: false,
        });
      }
    }
    return dateWiseList;
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
