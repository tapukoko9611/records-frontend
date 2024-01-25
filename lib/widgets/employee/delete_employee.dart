import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:records/blocs/employee/employee_bloc.dart";
import "package:records/models/employee/employee.dart";

class DeleteEmployeeWidget extends StatefulWidget {
  final String id;

  const DeleteEmployeeWidget({super.key, required this.id});

  @override
  State<DeleteEmployeeWidget> createState() => _DeleteEmployeeWidgetState();
}

class _DeleteEmployeeWidgetState extends State<DeleteEmployeeWidget> {
  Widget? errorMessage;

  _DeleteEmployeeWidgetState() {}

  void initState() {
    super.initState();
    errorMessage = Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          print("Employee Delete Widget state: ");
          print(state);
          if(state is EmployeeDeleteFailure) {
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
          if(state is EmployeeDeleteLoading) {
            // setState(() {
            errorMessage = Container(
                padding: const EdgeInsets.all(10),
                child: const CircularProgressIndicator.adaptive()
            );
            // });
          }
          if(state is EmployeeDeleteSuccess) {
            // setState(() {
            errorMessage = Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Successfully deleted",
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
                              "Delete Employee",
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
                              child: Text(
                                "Deleting this employee deletes all the demands made by him/her.\nAre you sure you want to delete this employee??",
                                overflow: TextOverflow.fade,
                                maxLines: 5,
                                softWrap: true,
                              ),
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(10),
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
                              context.read<EmployeeBloc>().add(DeleteEmployee(id: widget.id));
                              // if(state is EmployeeDeleteSuccess) {
                              //   // Navigator.of(context).pop();
                              //   // Navigator.of(context).pop();
                              //   Navigator.of(context).pop();
                              //   // int count = 0;
                              //   // Navigator.of(context).popUntil((_) => count++ >= 2);
                              // }
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
                                  "Okay",
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