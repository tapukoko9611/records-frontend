import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:records/blocs/employee/employee_bloc.dart";
import "package:records/models/employee/employee.dart";

class AddEmployeeWidget extends StatefulWidget {

  final List<Employee> employeeList;

  const AddEmployeeWidget({super.key, required this.employeeList});

  @override
  State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState(employeeList);
}

class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {

  final List<Employee> employeeList;
  final TextEditingController _filter = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _identity = TextEditingController();
  String _searchText = "";
  List<Employee> filteredList = [];
  // Widget? submitButton;
  Widget? errorMessage;

  _AddEmployeeWidgetState(this.employeeList) {
    errorMessage = Container();
    _filter.addListener(() {
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = [];
        });
      }
      else {
        setState(() {
          _searchText = _filter.text;
          filteredList = _searchText==""? []: employeeList.where((employee) =>
              employee.designation.contains(_searchText.toUpperCase())
          ).toList();
        });
      }
    });
    // _name.addListener(() {
    //   if(_filter.text.isNotEmpty && _name.text.isNotEmpty) {
    //     setState(() {
    //       submitButton = Padding(
    //         padding: const EdgeInsets.all(20.0),
    //         child: GestureDetector(
    //
    //           onTap: () {
    //             if (_filter.text.length==0 || _name.text.length==0) {
    //               showDialog(
    //                   context: context,
    //                   builder: (_) {
    //                     return AlertDialog(
    //                       content: Container(
    //                         // alignment: Alignment.center,
    //                         padding: EdgeInsets.all(20),
    //                         child: const Text(
    //                           "Fill All Fields!",
    //                           style: TextStyle(
    //                               color: Colors.redAccent,
    //                               fontSize: 20,
    //                               fontWeight: FontWeight.w600
    //                           ),
    //                         ),
    //                       ),
    //                     );
    //                   }
    //               );
    //             }
    //             else {
    //               Navigator.of(context).pop();
    //             }
    //             print({_filter.text, _name.text, _identity.text});
    //           },
    //           child: Container(
    //             margin: const EdgeInsets.only(left: 60, right: 60),
    //             decoration: const BoxDecoration(
    //               borderRadius: BorderRadius.all(Radius.circular(20)),
    //               gradient: LinearGradient(
    //                   begin: Alignment.topCenter,
    //                   end: Alignment.bottomCenter,
    //                   colors: [
    //                     Color(0xffc9880b),
    //                     Color(0xfff77f00),
    //                   ]
    //               ),
    //             ),
    //             child: const Center(
    //                 child: Text(
    //                   "Submit",
    //                   style: TextStyle(
    //                       color:Colors.white70,
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.w800
    //                   ),
    //                 )
    //             ),
    //           ),
    //         ),
    //       );
    //     });
    //   }
    // });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is EmployeeAddFailure) {
          // setState(() {
            errorMessage = Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                state.error.split(":")[1],
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
          // });
        }
        if(state is EmployeeAddSuccess) {
          // setState(() {
            errorMessage = Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Employee Added:\n${state.addedEmployee.id}",
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                maxLines: 2,
                softWrap: true,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.greenAccent
                ),
              ),
            );
          // });
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
        if(state is EmployeeAddLoading) {
          // setState(() {
            errorMessage = Container(
                padding: const EdgeInsets.all(10),
                child: const CircularProgressIndicator.adaptive()
            );
          // });
        }
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.hardEdge,
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -15,
                  top: -15,
                  width: 30,
                  height: 30,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close, size: 18,),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color:Colors.yellow.withOpacity(0.2),
                            border: Border(
                                bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
                            )
                        ),
                        child: const Center(
                            child: Text(
                                "Add Employee",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "Helvetica"
                                )
                            )
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(35),
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: _filter,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "Designation",
                                      prefixIcon: Icon(Icons.account_circle, ),
                                      focusColor: Colors.blue,
                                      hintStyle: TextStyle(
                                          color:Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                height: filteredList.length>=3? 100: filteredList.length==2? 70: filteredList.length==1? 40: 0,
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.blue.shade200, blurRadius: 5)],
                                    border: Border(bottom: BorderSide(color: Colors.blue.shade300))
                                ),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  clipBehavior: Clip.hardEdge,
                                  child: Column(
                                    children: filteredList.map((employee) {
                                      return Container(
                                        margin: const EdgeInsets.only(left: 30),
                                        child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(left: 10, top: 10),
                                                child: Icon(
                                                    Icons.error_outline,
                                                    size: 13,
                                                    color: Colors.red.shade400
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 10, top: 10),
                                                child: Text(
                                                  employee.designation,
                                                  style: TextStyle(
                                                    color: Colors.red.shade400,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  controller: _name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "Name",
                                      prefixIcon: Icon(Icons.admin_panel_settings, ),
                                      focusColor: Colors.blue,
                                      hintStyle: TextStyle(
                                          color:Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  controller: _identity,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "Identity",
                                      prefixIcon: Icon(Icons.badge, ),
                                      focusColor: Colors.blue,
                                      hintStyle: TextStyle(
                                          color:Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      errorMessage!,
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(

                          onTap: () {
                            if (_filter.text.length==0 || _name.text.length==0) {
                              // showDialog(
                              //     context: context,
                              //     builder: (_) {
                              //       return AlertDialog(
                              //         content: Container(
                              //           // alignment: Alignment.center,
                              //           padding: EdgeInsets.all(20),
                              //           child: const Text(
                              //             "Fill All Fields!",
                              //             style: TextStyle(
                              //                 color: Colors.redAccent,
                              //                 fontSize: 20,
                              //                 fontWeight: FontWeight.w600
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }
                              // );
                              setState(() {
                                errorMessage = Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Please fill all the fields!",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    maxLines: 2,
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
                              context.read<EmployeeBloc>().add(AddEmployee(designation: _filter.text, name: _name.text, identity: _identity.text));
                              // Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 60, right: 60),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffc9880b),
                                    Color(0xfff77f00),
                                  ]
                              ),
                            ),
                            child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color:Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),
                                )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
      // child: AlertDialog(
      //   contentPadding: EdgeInsets.zero,
      //   content: SingleChildScrollView(
      //     physics: const ClampingScrollPhysics(),
      //     scrollDirection: Axis.vertical,
      //     clipBehavior: Clip.hardEdge,
      //     // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //     child: Stack(
      //       clipBehavior: Clip.none,
      //       children: <Widget>[
      //         Positioned(
      //           right: -15,
      //           top: -15,
      //           width: 30,
      //           height: 30,
      //           child: InkResponse(
      //             onTap: () {
      //               Navigator.of(context).pop();
      //             },
      //             child: const CircleAvatar(
      //               radius: 12,
      //               backgroundColor: Colors.red,
      //               child: Icon(Icons.close, size: 18,),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: <Widget>[
      //               Container(
      //                 height: 60,
      //                 width: MediaQuery.of(context).size.width,
      //                 decoration: BoxDecoration(
      //                     color:Colors.yellow.withOpacity(0.2),
      //                     border: Border(
      //                         bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
      //                     )
      //                 ),
      //                 child: const Center(
      //                     child: Text(
      //                         "Add Employee",
      //                         style: TextStyle(
      //                             color: Colors.black54,
      //                             fontWeight: FontWeight.w700,
      //                             fontSize: 20,
      //                             fontStyle: FontStyle.italic,
      //                             fontFamily: "Helvetica"
      //                         )
      //                     )
      //                 ),
      //               ),
      //               Container(
      //                   padding: const EdgeInsets.all(35),
      //                   child: Column(
      //                     children: [
      //                       Container(
      //                         child: TextFormField(
      //                           controller: _filter,
      //                           style: const TextStyle(
      //                             fontWeight: FontWeight.w500,
      //                             fontSize: 20
      //                           ),
      //                           decoration: const InputDecoration(
      //                               hintText: "Designation",
      //                               prefixIcon: Icon(Icons.account_circle, ),
      //                               focusColor: Colors.blue,
      //                               hintStyle: TextStyle(
      //                                   color:Colors.black26,
      //                                   fontSize: 18,
      //                                   fontWeight: FontWeight.w500
      //                               )
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         height: filteredList.length>=3? 100: filteredList.length==2? 70: filteredList.length==1? 40: 0,
      //                         decoration: BoxDecoration(
      //                           boxShadow: [BoxShadow(color: Colors.blue.shade200, blurRadius: 5)],
      //                           border: Border(bottom: BorderSide(color: Colors.blue.shade300))
      //                         ),
      //                         child: SingleChildScrollView(
      //                           physics: const ClampingScrollPhysics(),
      //                           scrollDirection: Axis.vertical,
      //                           clipBehavior: Clip.hardEdge,
      //                           child: Column(
      //                             children: filteredList.map((employee) {
      //                                 return Container(
      //                                   margin: const EdgeInsets.only(left: 30),
      //                                   child: Row(
      //                                     children: [
      //                                       Container(
      //                                         padding: const EdgeInsets.only(left: 10, top: 10),
      //                                         child: Icon(
      //                                             Icons.error_outline,
      //                                             size: 13,
      //                                             color: Colors.red.shade400
      //                                         ),
      //                                       ),
      //                                       Container(
      //                                         padding: const EdgeInsets.only(left: 10, top: 10),
      //                                         child: Text(
      //                                           employee.designation,
      //                                           style: TextStyle(
      //                                             color: Colors.red.shade400,
      //                                             fontSize: 13,
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ]
      //                                   ),
      //                                 );
      //                               }).toList(),
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         child: TextFormField(
      //                           controller: _name,
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.w500,
      //                               fontSize: 20
      //                           ),
      //                           decoration: const InputDecoration(
      //                               hintText: "Name",
      //                               prefixIcon: Icon(Icons.admin_panel_settings, ),
      //                               focusColor: Colors.blue,
      //                               hintStyle: TextStyle(
      //                                   color:Colors.black26,
      //                                   fontSize: 18,
      //                                   fontWeight: FontWeight.w500
      //                               )
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         child: TextFormField(
      //                           controller: _identity,
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.w500,
      //                               fontSize: 20
      //                           ),
      //                           decoration: const InputDecoration(
      //                               hintText: "Identity",
      //                               prefixIcon: Icon(Icons.badge, ),
      //                               focusColor: Colors.blue,
      //                               hintStyle: TextStyle(
      //                                   color:Colors.black26,
      //                                   fontSize: 18,
      //                                   fontWeight: FontWeight.w500
      //                               )
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   )
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(20.0),
      //                 child: GestureDetector(
      //
      //                   onTap: () {
      //                     if (_filter.text.length==0 || _name.text.length==0) {
      //                       showDialog(
      //                           context: context,
      //                           builder: (_) {
      //                             return AlertDialog(
      //                               content: Center(
      //                                 child: Container(
      //                                   child: const Text(
      //                                     "Fill All Fields!",
      //                                     style: TextStyle(
      //                                       color: Colors.redAccent,
      //                                       fontSize: 20,
      //                                       fontWeight: FontWeight.w600
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                             );
      //                           }
      //                       );
      //                     }
      //                     else {
      //                       Navigator.of(context).pop();
      //                     }
      //                     print({_filter.text, _name.text, _identity.text});
      //                   },
      //                   child: Container(
      //                     margin: const EdgeInsets.only(left: 60, right: 60),
      //                     decoration: const BoxDecoration(
      //                       borderRadius: BorderRadius.all(Radius.circular(20)),
      //                         gradient: LinearGradient(
      //                             begin: Alignment.topCenter,
      //                             end: Alignment.bottomCenter,
      //                             colors: [
      //                               Color(0xffc9880b),
      //                               Color(0xfff77f00),
      //                             ]
      //                         ),
      //                     ),
      //                     child: const Center(
      //                         child: Text(
      //                           "Submit",
      //                           style: TextStyle(
      //                               color:Colors.white70,
      //                               fontSize: 20,
      //                               fontWeight: FontWeight.w800
      //                           ),
      //                         )
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

// AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           content: SingleChildScrollView(
//             physics: const ClampingScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             clipBehavior: Clip.hardEdge,
//             // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: <Widget>[
//                 Positioned(
//                   right: -15,
//                   top: -15,
//                   width: 30,
//                   height: 30,
//                   child: InkResponse(
//                     onTap: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const CircleAvatar(
//                       radius: 12,
//                       backgroundColor: Colors.red,
//                       child: Icon(Icons.close, size: 18,),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Container(
//                         height: 60,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                             color:Colors.yellow.withOpacity(0.2),
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
//                             )
//                         ),
//                         child: const Center(
//                             child: Text(
//                                 "Add Employee",
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 20,
//                                     fontStyle: FontStyle.italic,
//                                     fontFamily: "Helvetica"
//                                 )
//                             )
//                         ),
//                       ),
//                       Container(
//                           padding: const EdgeInsets.all(35),
//                           child: Column(
//                             children: [
//                               Container(
//                                 child: TextFormField(
//                                   controller: _filter,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 20
//                                   ),
//                                   decoration: const InputDecoration(
//                                       hintText: "Designation",
//                                       prefixIcon: Icon(Icons.account_circle, ),
//                                       focusColor: Colors.blue,
//                                       hintStyle: TextStyle(
//                                           color:Colors.black26,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       )
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: filteredList.length>=3? 100: filteredList.length==2? 70: filteredList.length==1? 40: 0,
//                                 decoration: BoxDecoration(
//                                     boxShadow: [BoxShadow(color: Colors.blue.shade200, blurRadius: 5)],
//                                     border: Border(bottom: BorderSide(color: Colors.blue.shade300))
//                                 ),
//                                 child: SingleChildScrollView(
//                                   physics: const ClampingScrollPhysics(),
//                                   scrollDirection: Axis.vertical,
//                                   clipBehavior: Clip.hardEdge,
//                                   child: Column(
//                                     children: filteredList.map((employee) {
//                                       return Container(
//                                         margin: const EdgeInsets.only(left: 30),
//                                         child: Row(
//                                             children: [
//                                               Container(
//                                                 padding: const EdgeInsets.only(left: 10, top: 10),
//                                                 child: Icon(
//                                                     Icons.error_outline,
//                                                     size: 13,
//                                                     color: Colors.red.shade400
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: const EdgeInsets.only(left: 10, top: 10),
//                                                 child: Text(
//                                                   employee.designation,
//                                                   style: TextStyle(
//                                                     color: Colors.red.shade400,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ]
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 child: TextFormField(
//                                   controller: _name,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 20
//                                   ),
//                                   decoration: const InputDecoration(
//                                       hintText: "Name",
//                                       prefixIcon: Icon(Icons.admin_panel_settings, ),
//                                       focusColor: Colors.blue,
//                                       hintStyle: TextStyle(
//                                           color:Colors.black26,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       )
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 child: TextFormField(
//                                   controller: _identity,
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 20
//                                   ),
//                                   decoration: const InputDecoration(
//                                       hintText: "Identity",
//                                       prefixIcon: Icon(Icons.badge, ),
//                                       focusColor: Colors.blue,
//                                       hintStyle: TextStyle(
//                                           color:Colors.black26,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       )
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: GestureDetector(
//
//                           onTap: () {
//                             if (_filter.text.length==0 || _name.text.length==0) {
//                               showDialog(
//                                   context: context,
//                                   builder: (_) {
//                                     return AlertDialog(
//                                       content: Container(
//                                         // alignment: Alignment.center,
//                                         padding: EdgeInsets.all(20),
//                                         child: const Text(
//                                           "Fill All Fields!",
//                                           style: TextStyle(
//                                               color: Colors.redAccent,
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.w600
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }
//                               );
//                             }
//                             else {
//                               Navigator.of(context).pop();
//                             }
//                             print({_filter.text, _name.text, _identity.text});
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(left: 60, right: 60),
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(20)),
//                               gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Color(0xffc9880b),
//                                     Color(0xfff77f00),
//                                   ]
//                               ),
//                             ),
//                             child: const Center(
//                                 child: Text(
//                                   "Submit",
//                                   style: TextStyle(
//                                       color:Colors.white70,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w800
//                                   ),
//                                 )
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
