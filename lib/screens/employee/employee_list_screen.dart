import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:records/blocs/employee/employee_bloc.dart';
import 'package:records/models/employee/employee.dart';
import 'package:records/widgets/employee/add_employee.dart';
import 'package:records/widgets/employee/employee_list.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> with SingleTickerProviderStateMixin{

  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List<Employee> employeeList = [];
  List<Employee> empList = [];
  List<Employee> filteredList = [];
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Employee List");
  Widget? tempWidget;
  FocusNode focusNode = FocusNode();

  _EmployeeListScreenState() {
    _filter.addListener(() {
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = employeeList;
          tempWidget = AddEmployeeButton(context, employeeList);
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
    context.read<EmployeeBloc>().add(FetchEmployeeList());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildBar(context),
      body: _buildList(context),
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
        _appBarTitle = const Text("Employee List");
        filteredList = employeeList;
        _filter.clear();
        // focusNode.dispose();
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
            context.read<EmployeeBloc>().add(FetchEmployeeList());
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
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              print("Listening state");
              print(state);
              // if(state is EmployeeRecordLoaded) {
              //   employeeList = state.employeeListWithARecord;
              // }
            },
            builder: (context, state) {
              print("Employee List Screen state: ");
              print(state);
              if(state is EmployeeListFailure) {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                return Center(
                    child: Text("Error: ${state.error}.\n Please Reload")
                  // child: Container(
                  //   margin: const EdgeInsets.only(top: 100),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Text("Error: ${state.error}"),
                  //       IconButton(
                  //         onPressed: () {
                  //           context.read<EmployeeBloc>().add(FetchEmployeeList());
                  //         },
                  //         icon: const Icon(Icons.refresh),
                  //         tooltip: "Refresh",
                  //       ),
                  //     ],
                  //   ),
                  // )
                );
              }

              // *****************IMP*************************
              // if(state is EmployeeListLoading) {
              //   return const Center(child: CircularProgressIndicator.adaptive(),);
              // }


              // final employeeList = state.employeeList;
              // employeeList.sort((a, b) => a.designation.compareTo(b.designation));
              // var searchList = employeeList;

              // setState(() {

              // if(state is! EmployeeListLoaded) {
              //   return const Center(child: CircularProgressIndicator.adaptive(),);
              // }
              // employeeList =  state.employeeList;

              if (state is EmployeeListLoading) {
                return const Center(child: CircularProgressIndicator.adaptive(),);
              }
              if (state is EmployeeListLoaded) {
                employeeList = state.employeeList;
              }
              if (state is EmployeeRecordLoaded) {
                employeeList = state.employeeListWithARecord;
              }

              employeeList.sort((a, b) => a.designation.compareTo(b.designation));
              filteredList = employeeList;
              tempWidget = AddEmployeeButton(context, employeeList);
              // });

              if(_searchText.isNotEmpty) {
                // List<Employee> tempList = [];
                // for(int i=0; i<filteredList.length; i++) {
                //   if(filteredList[i].designation.contains(_searchText.toUpperCase()) || filteredList[i].identity!.contains(_searchText.toUpperCase())) {
                //     tempList.add(filteredList[i]);
                //   }
                // }
                // filteredList = tempList;
                // filteredList.sort((a, b) => a.designation.compareTo(b.designation));

                filteredList = filteredList.where((employee) =>
                    employee.designation.contains(_searchText.toUpperCase())
                  // || employee.identity!.contains(_searchText.toUpperCase())
                ).toList();
                if (filteredList.isNotEmpty) {
                  tempWidget = const SizedBox(height: 10,);
                }
                else {
                  tempWidget = AddEmployeeButton(context, employeeList);
                }
              }

              return GestureDetector(
                // behavior: HitTestBehavior.opaque,
                // onPanDown: (_) {
                //   FocusScope.of(context).requestFocus(FocusNode());
                // },
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.hardEdge,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                      children: [
                        tempWidget!,
                        ...filteredList.map((employee) {
                          return SingleEmpCard(
                            id: employee.id,
                            designation: employee.designation,
                            identity: employee.identity,
                            name: employee.name,
                            today: employee.count[0],
                            monthly: employee.count[1],
                            all_time: employee.count[2],
                            context: context
                          );
                        }).toList(),
                      ]
                  )
                ),
              );
            }
        )
    );
  }

  Widget _buildList1(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.hardEdge,
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
            listener: (context, state) {
              if(state is EmployeeInitial) {}
            },
            builder: (context, state) {
              if(state is EmployeeListFailure) {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                return Center(
                    child: Text("Error: ${state.error}.\n Please Reload")
                  // child: Container(
                  //   margin: const EdgeInsets.only(top: 100),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Text("Error: ${state.error}"),
                  //       IconButton(
                  //         onPressed: () {
                  //           context.read<EmployeeBloc>().add(FetchEmployeeList());
                  //         },
                  //         icon: const Icon(Icons.refresh),
                  //         tooltip: "Refresh",
                  //       ),
                  //     ],
                  //   ),
                  // )
                );
              }

              // *****************IMP*************************
              // if(state is EmployeeListLoading) {
              //   return const Center(child: CircularProgressIndicator.adaptive(),);
              // }

              if(state is! EmployeeListLoaded) {
                return const Center(child: CircularProgressIndicator.adaptive(),);
              }

              // final employeeList = state.employeeList;
              // employeeList.sort((a, b) => a.designation.compareTo(b.designation));
              // var searchList = employeeList;

              // setState(() {
              employeeList =  state.employeeList;
              employeeList.sort((a, b) => a.designation.compareTo(b.designation));
              filteredList = employeeList;
              // });

              if(_searchText.isNotEmpty) {
                // List<Employee> tempList = [];
                // for(int i=0; i<filteredList.length; i++) {
                //   if(filteredList[i].designation.contains(_searchText.toUpperCase()) || filteredList[i].identity!.contains(_searchText.toUpperCase())) {
                //     tempList.add(filteredList[i]);
                //   }
                // }
                // filteredList = tempList;
                // filteredList.sort((a, b) => a.designation.compareTo(b.designation));

                filteredList = filteredList.where((employee) =>
                    employee.designation.contains(_searchText.toUpperCase())
                  // || employee.identity!.contains(_searchText.toUpperCase())
                ).toList();
              }

              return Container(
                // height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))
                  ),
                  child: Column(
                      children: filteredList.map((employee) {
                        return SingleEmpCard(
                            id: employee.id,
                            designation: employee.designation,
                            identity: employee.identity,
                            name: employee.name,
                            today: employee.count[0],
                            monthly: employee.count[1],
                            all_time: employee.count[2],
                            context: context
                        );
                      }).toList()
                  )
              );
            }
        )
    );
  }
}


