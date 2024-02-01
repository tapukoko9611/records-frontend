import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:intl/intl.dart";
import "package:records/blocs/transaction/transaction_bloc.dart";
import "package:records/models/skeleton/skeleton.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/widgets/transaction/add_transaction.dart";


class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  Skeleton skeleton = Skeleton();
  List<String> employees = [];
  List<String> suppliers = [];
  List<String> stationery = [];

  String type = "DEMAND"; // demand, supply
  TextEditingController dateText = TextEditingController();
  TextEditingController reference = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController price = TextEditingController();
  DateTime date = DateTime.now();

  String person = "";
  String personState = "INVALID";
  void changePersonState(String person, String personState) {
    setState(() {
      this.person = person;
      this.personState = personState;
    });
    // print("__________________");
    // print([person, this.person]);
    // print([personState, this.personState]);
  }

  List itemList = [];
  String itemListState = "INVALID"; //{"item": "", "quantity": 0, "remarks": 0, "price": 0, "state": "INVALID"};
  void changeListState(List list, String state) {
    setState(() {
      itemList = list;
      itemListState = state;
    });
  }

  @override
  void initState() {
    super.initState();
  }
  _AddTransactionState() {}

  Widget errorMessage = Container();
  void validateDetails() {
    if(type=="DEMAND" && personState=="INVALID") {
      setState(() {
        errorMessage = Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Invalid Employee Designation",
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: 5,
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.redAccent
            ),
          ),
        );
      });
    }
    else if(type=="SUPPLY" && personState=="INVALID" && person.trim().length==0) {
      setState(() {
        errorMessage = Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Invalid Supplier Organization",
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: 5,
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.redAccent
            ),
          ),
        );
      });
    }
    else if(type=="DEMAND" && itemListState=="INVALID") {
      setState(() {
        errorMessage = Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Invalid Item selection",
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: 5,
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.redAccent
            ),
          ),
        );
      });
    }
    else if(itemList.isEmpty) {
      setState(() {
        errorMessage = Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Invalid Item selection",
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: 5,
            softWrap: true,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.redAccent
            ),
          ),
        );
      });
    }
    else {
      // setState(() {
      //   errorMessage = Container(
      //     padding: const EdgeInsets.all(10),
      //     child: const Text(
      //       "DONE! GOOD",
      //       textAlign: TextAlign.center,
      //       overflow: TextOverflow.visible,
      //       maxLines: 5,
      //       softWrap: true,
      //       style: TextStyle(
      //           fontWeight: FontWeight.w600,
      //           fontSize: 20,
      //           color: Colors.greenAccent
      //       ),
      //     ),
      //   );
      // });
      Map transaction = {};
      transaction["type"] = type;
      transaction["person"] = person;
      transaction["date"] = date;
      transaction["reference"] = reference.text;
      transaction["remarks"] = remarks.text;
      if(type=="SUPPLY") {
        transaction["price"] = price.text.length>0? int.parse(price.text): 0;
      }
      var items = [];
      for (int i=0; i<itemList.length; i++) {
        var item = itemList[i];
        if ((item["state"]=="VALID" || type=="SUPPLY") && item["item"].trim().length>0 && item["quantity"]>0) {
          items.add({
            "name": item["item"],
            "remarks": item["remarks"],
            "quantity": type=="DEMAND"? item["quantity"]*(-1): item["quantity"],
            "price": item["price"]
          });
        }
      }
      transaction["list"] = items;
      context.read<TransactionBloc>().add(NewTransaction(transaction: transaction));
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is TransactionListFailure) {
          return Center(
              child: Text("Error: ${state.error}.\n Please Reload")
          );
        }
        if(state is TransactionAddFailure) {
          errorMessage = Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              state.error,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.redAccent
              ),
            ),
          );
        }
        if(state is TransactionAddSuccess) {
          errorMessage = Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Transaction successfully added",
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 5,
              softWrap: true,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.greenAccent
              ),
            ),
          );
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
        if(state is! TransactionListLoaded) {
          return const Center(child: CircularProgressIndicator.adaptive(),);
        }

        skeleton = state.skeleton;
        employees = List.from(skeleton.employees!.map((e) => e.designation));
        suppliers = List.from(skeleton.suppliers!.map((e) => e.organization));
        stationery = List.from(skeleton.stationery!.map((e) => e.name));

        return Scaffold(
          appBar: AppBar(title: const Text("Add transaction"), backgroundColor: Colors.teal),
          body: Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))
            ),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.hardEdge,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                 children: [
                   Container(
                     decoration: BoxDecoration(
                       color: Colors.grey,
                       borderRadius: BorderRadius.circular(10)
                     ),
                     margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(5),
                     child: Row(
                       children: [
                         Container(
                           width: 170,
                           alignment: Alignment.centerRight,
                           margin: const EdgeInsets.only(top: 10, right: 10),
                           child: const Text(
                             "Type :",
                             style: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                         ),
                         DropdownButton<String>(
                           value: type,
                           icon: const Icon(Icons.arrow_downward),
                           elevation: 16,
                           style: const TextStyle(color: Colors.deepPurple),
                           underline: Container(
                             height: 2,
                             color: Colors.deepPurpleAccent,
                           ),
                           onChanged: (String? value) {
                             setState(() {
                               type = value!;
                             });
                           },
                           items: ["DEMAND", "SUPPLY"].map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value),
                             );
                           }).toList(),
                         )
                       ],
                     ),
                   ),
                   Container(
                     margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       color: type=="DEMAND"? Colors.redAccent.shade400.withOpacity(0.4): Colors.greenAccent.shade400.withOpacity(0.4),
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: Column(
                       children: [
                         Container(
                             padding: EdgeInsets.all(5),
                             // height:150,
                             child:Center(
                                 child:TextField(
                                   controller: dateText, //editing controller of this TextField
                                   decoration: const InputDecoration(
                                       icon: Icon(Icons.calendar_today), //icon of text field
                                       labelText: "Enter Date" //label text of field
                                   ),
                                   readOnly: true,  //set it true, so that user will not able to edit text
                                   onTap: () async {
                                     DateTime? pickedDate = await showDatePicker(
                                         context: context, initialDate: DateTime.now(),
                                         firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                         lastDate: DateTime(2101)
                                     );

                                     if(pickedDate != null ){
                                       String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                                       setState(() {
                                         date = pickedDate;
                                         dateText.text = formattedDate; //set output date to TextField value.
                                       });
                                     }
                                     else {
                                       date = DateTime.now();
                                     }
                                   },
                                   style: TextStyle(),
                                 )
                             )
                         ),
                         Container(
                             padding: EdgeInsets.all(5),
                             // height:150,
                             child:Center(
                                 child:TextField(
                                     controller: reference, //editing controller of this TextField
                                     decoration: const InputDecoration(
                                         icon: Icon(Icons.calendar_today), //icon of text field
                                         labelText: "Enter Reference no." //label text of field
                                     )
                                 )
                             )
                         ),
                         PersonSelectionWidget(
                           personList: type=="DEMAND"? employees: suppliers,
                           personState: personState,
                           changePersonState: changePersonState,
                           type: type,
                         ),
                         type=="SUPPLY"? Container(
                             padding: EdgeInsets.all(5),
                             child:Center(
                                 child:TextField(
                                   controller: price, //editing controller of this TextField
                                   decoration: const InputDecoration(
                                       icon: Icon(Icons.calendar_today), //icon of text field
                                       labelText: "Price" //label text of field
                                   ),
                                   keyboardType: TextInputType.number,
                                   inputFormatters: <TextInputFormatter>[
                                     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                     FilteringTextInputFormatter.digitsOnly
                                   ],
                                 )
                             )
                         ): Container(),
                         Container(
                             padding: EdgeInsets.all(5),
                             child:Center(
                                 child:TextField(
                                     controller: remarks, //editing controller of this TextField
                                     decoration: const InputDecoration(
                                         icon: Icon(Icons.calendar_today), //icon of text field
                                         labelText: "Remarks" //label text of field
                                     ),
                                   maxLines: null,
                                   keyboardType: TextInputType.multiline,
                                 )
                             )
                         ),
                         const SizedBox(height: 15,),
                         ItemList(stationeryList: stationery, changeListState: changeListState, type: type),
                         errorMessage,
                         GestureDetector(
                           onTap: () => validateDetails(),
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
                               alignment: Alignment.center,
                               child: const Text(
                                 "Make Transaction",
                                 style: TextStyle(
                                   fontWeight: FontWeight.w500,
                                   fontSize: 17
                                 ),
                               )
                           ),
                         )
                       ],
                     ),
                   )
                 ],
              ),
            ),
          ),
        );
      },
    );
  }
}
