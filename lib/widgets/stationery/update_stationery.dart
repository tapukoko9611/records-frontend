import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:records/blocs/stationery/stationery_bloc.dart";
import "package:records/models/employee/employee.dart";

class UpdateStationeryWidget extends StatefulWidget {
  final String id;
  final String name;
  final int quantity;
  final String image;

  const UpdateStationeryWidget({super.key, required this.id, required this.name, required this.quantity, required this.image});

  @override
  State<UpdateStationeryWidget> createState() => _UpdateStationeryWidgetState();
}

class _UpdateStationeryWidgetState extends State<UpdateStationeryWidget> {

  final TextEditingController _name= TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _image = TextEditingController();
  Widget? errorMessage;

  _UpdateStationeryWidgetState() {


    // print(widget);
    // errorMessage = Container();
    // _designation.text = widget.designation?? " ";
    // _name.text = widget.name?? " ";
    // _identity.text = widget.identity?? " ";
  }

  void initState() {
    super.initState();
    errorMessage = Container();
    _name.text = widget.name?? " ";
    _quantity.text = widget.quantity.toString()?? "0";
    _image.text = widget.image?? " ";
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StationeryBloc, StationeryState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          if(state is StationeryUpdateFailure) {
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
          if(state is StationeryUpdateSuccess) {
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
          if(state is StationeryUpdateLoading) {
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
                              "Update Stationery",
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
                                controller: _name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),
                                decoration: const InputDecoration(
                                    hintText: "Name",
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
                                controller: _quantity,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),
                                decoration: const InputDecoration(
                                    hintText: "Quantity",
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
                                controller: _image,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                ),
                                decoration: const InputDecoration(
                                    hintText: "Image",
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
                            if (_name.text.trim().length==0) {
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
                            if (_quantity.text.length != 0 &&
                                (!isNumeric(_quantity.text) ||
                                    _quantity.text.contains("-") ||
                                    _quantity.text.contains("."))) {
                              setState(() {
                                errorMessage = Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    "Please enter a valid quantity!",
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
                              context.read<StationeryBloc>().add(UpdateStationery(id: widget.id, name: _name.text, quantity: _quantity.text.trim().length>0? int.parse(_quantity.text.trim()): 0, image: _image.text));
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