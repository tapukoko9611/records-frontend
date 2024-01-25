import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:records/blocs/employee/employee_bloc.dart";
import "package:records/models/employee/employee.dart";

class UpdateEmployeeWidget extends StatefulWidget {
  final String id;
  final String designation;
  final String name;
  final String identity;

  const UpdateEmployeeWidget({super.key, required this.designation, required this.name, required this.identity, required this.id});

  @override
  State<UpdateEmployeeWidget> createState() => _UpdateEmployeeWidgetState();
}

class _UpdateEmployeeWidgetState extends State<UpdateEmployeeWidget> {

  final TextEditingController _designation= TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _identity = TextEditingController();
  Widget? errorMessage;

  _UpdateEmployeeWidgetState() {


    // print(widget);
    // errorMessage = Container();
    // _designation.text = widget.designation?? " ";
    // _name.text = widget.name?? " ";
    // _identity.text = widget.identity?? " ";
  }

  void initState() {
    super.initState();
    errorMessage = Container();
    _designation.text = widget.designation?? " ";
    _name.text = widget.name?? " ";
    _identity.text = widget.identity?? " ";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          if(state is EmployeeUpdateFailure) {
            // setState(() {
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
            // });
          }
          if(state is EmployeeUpdateSuccess) {
            // setState(() {
            errorMessage = Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Successfully updated",
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
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
          }
          if(state is EmployeeUpdateLoading) {
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
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color:Colors.amberAccent.shade400.withOpacity(0.4),
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.withOpacity(0.3))
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))
                      ),
                      child: const Center(
                          child: Text(
                              "Update Employee",
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
                                controller: _designation,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.redAccent.shade400
                            ),
                            child: const Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color:Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800
                                  ),
                                )
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_designation.text.length==0 || _name.text.length==0) {
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
                              // print([widget.id, _designation.text, _name.text, _identity.text]);
                              context.read<EmployeeBloc>().add(UpdateEmployee(id: widget.id, designation: _designation.text, name: _name.text, identity: _identity.text));
                              // Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.greenAccent.shade400
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
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}