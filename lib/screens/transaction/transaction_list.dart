import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:intl/intl.dart";
import "package:records/blocs/transaction/transaction_bloc.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/widgets/employee/employee_record.dart";
import "package:records/widgets/transaction/transaction_list.dart";

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {

  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List<Transaction> transactionList = [];
  List<dynamic> filteredList = [];
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Transaction List");
  Widget? tempWidget;
  FocusNode focusNode = FocusNode();

  _TransactionListScreenState() {
    _filter.addListener(() {
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = _getDateWiseList(transactionList);
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
        filteredList = _getDateWiseList(transactionList);
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

              transactionList =  state.transactionList;
              transactionList.sort((a, b) => a.date.isBefore(b.date) == true? 1: 0);
              filteredList = _getDateWiseList(transactionList);
              tempWidget = AddTransactionButton(context);

              if(_searchText.isNotEmpty) {
                filteredList = filteredList.where((item) =>
                    item["date"].contains(_searchText.toUpperCase())
                ).toList();
                if (filteredList.isNotEmpty) {
                  tempWidget = const SizedBox(height: 10,);
                }
                else {
                  tempWidget = AddTransactionButton(context);
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
                          tempWidget!,
                          ...filteredList.map((dateWise) {
                            return DateWiseWidget(date: dateWise["date"], transactions: dateWise["transactions"]);
                          }).toList()
                        ]
                    )
                ),
              );
            }
        )
    );
  }

  List<dynamic> _getDateWiseList(List<Transaction> list) {
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
        }
      }
      if (!hasDate) {
        dateWiseList.add({
          "date": date,
          "transactions": [transaction]
        });
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
