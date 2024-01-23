import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:records/blocs/stationery/stationery_bloc.dart";
import "package:records/models/stationery/stationery.dart";

class AddStationeryWidget extends StatefulWidget {

  final List<Stationery> stationeryList;

  const AddStationeryWidget({super.key, required this.stationeryList});

  @override
  State<AddStationeryWidget> createState() => _AddStationeryWidgetState(stationeryList);
}

class _AddStationeryWidgetState extends State<AddStationeryWidget> {

  final List<Stationery> stationeryList;
  final TextEditingController _filter = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _image = TextEditingController();
  String _searchText = "";
  List<Stationery> filteredList = [];
  Widget? errorMessage;

  _AddStationeryWidgetState(this.stationeryList) {
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
          filteredList = _searchText==""? []: stationeryList.where((stationery) =>
              stationery.name.contains(_searchText.toUpperCase())
          ).toList();
        });
      }
    });
  }

  void initState() {
    super.initState();
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
      listener: (context, state) {},
      builder: (context, state) {
        if (state is StationeryAddFailure) {
          errorMessage = Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              // try {
              //   return state.error.split("Exception: ")[1];
              // } catch() {
              //   return state.error;
              // }
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
        if (state is StationeryAddSuccess) {
          errorMessage = Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Stationery Added:\n${state.addedStationery.id}",
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
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        }
        if (state is StationeryAddLoading) {
          errorMessage = Container(
              padding: const EdgeInsets.all(10),
              child: const CircularProgressIndicator.adaptive()
          );
        }
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.hardEdge,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                            color: Colors.amberAccent.shade400.withOpacity(0.4),
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.3))
                            ),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28))
                        ),
                        child: const Center(
                            child: Text(
                                "Add Stationery",
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
                                      hintText: "Name",
                                      prefixIcon: Icon(Icons.inventory,),
                                      focusColor: Colors.blue,
                                      hintStyle: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),
                                ),
                              ),
                              Container(
                                height: filteredList.length >= 3
                                    ? 100
                                    : filteredList.length == 2
                                    ? 70
                                    : filteredList.length == 1 ? 40 : 0,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(color: Colors.blue.shade200,
                                          blurRadius: 5)
                                    ],
                                    border: Border(bottom: BorderSide(
                                        color: Colors.blue.shade300))
                                ),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  clipBehavior: Clip.hardEdge,
                                  child: Column(
                                    children: filteredList.map((stationery) {
                                      return Container(
                                        margin: const EdgeInsets.only(left: 30),
                                        child: Row(
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Icon(
                                                    Icons.error_outline,
                                                    size: 13,
                                                    color: Colors.red.shade400
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Text(
                                                  stationery.name,
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
                                  controller: _quantity,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20
                                  ),
                                  decoration: const InputDecoration(
                                      hintText: "Quantity",
                                      prefixIcon: Icon(Icons.tag,),
                                      focusColor: Colors.blue,
                                      hintStyle: TextStyle(
                                          color: Colors.black26,
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
                                      prefixIcon: Icon(Icons.image,),
                                      focusColor: Colors.blue,
                                      hintStyle: TextStyle(
                                          color: Colors.black26,
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
                            if (_filter.text.length == 0) {
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
                              if (_quantity.text.length != 0 &&
                                  (!isNumeric(_quantity.text) ||
                                      _quantity.text.contains("-") ||
                                      _quantity.text.contains("."))) {
                                setState(() {
                                  errorMessage = Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "Please fill enter a valid quantity!",
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
                            }
                            else {
                              context.read<StationeryBloc>().add(AddStationery(
                                  name: _filter.text,
                                  quantity: _quantity.text.length>0? int.parse(_quantity.text): 0,
                                  image: _image.text));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 60, right: 60),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)),
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
                                      color: Colors.white70,
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
    );
  }
}