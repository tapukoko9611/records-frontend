import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:records/blocs/stationery/stationery_bloc.dart';
import 'package:records/models/stationery/stationery.dart';
import 'package:records/widgets/stationery/stationery_list.dart';

class StationeryListScreen extends StatefulWidget {
  const StationeryListScreen({super.key});

  @override
  State<StationeryListScreen> createState() => _StationeryListScreenState();
}

class _StationeryListScreenState extends State<StationeryListScreen> with SingleTickerProviderStateMixin{
  
  final TextEditingController _filter = TextEditingController();
  String _searchText = "";
  List<Stationery> stationeryList = [];
  List<Stationery> filteredList = [];
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text("Stationery List");
  Widget? tempWidget;
  FocusNode focusNode = FocusNode();

  _StationeryListScreenState() {
    _filter.addListener(() {
      if(_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredList = stationeryList;
          tempWidget = AddStationeryButton(context, stationeryList);
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
    context.read<StationeryBloc>().add(FetchStationeryList());
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
        _appBarTitle = const Text("Stationery List");
        filteredList = stationeryList;
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
            context.read<StationeryBloc>().add(FetchStationeryList());
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
        child: BlocConsumer<StationeryBloc, StationeryState>(
            listener: (context, state) {
              if(state is StationeryInitial) {}
            },
            builder: (context, state) {
              if(state is StationeryListFailure) {
                return Center(
                    child: Text("Error: ${state.error}.\n Please Reload")
                );
              }
              if(state is StationeryListLoading) {
                return const Center(child: CircularProgressIndicator.adaptive(),);
              }
              if(state is StationeryListLoaded) {
                stationeryList =  state.stationeryList;
              }
              if(state is StationeryRecordLoaded) {
                stationeryList = state.stationeryListWithARecord;
              }


              stationeryList.sort((a, b) => a.name.compareTo(b.name));
              filteredList = stationeryList;
              tempWidget = AddStationeryButton(context, stationeryList);

              if(_searchText.isNotEmpty) {
                filteredList = filteredList.where((item) =>
                    item.name.contains(_searchText.toUpperCase())
                ).toList();
                if (filteredList.isNotEmpty) {
                  tempWidget = const SizedBox(height: 10,);
                }
                else {
                  tempWidget = AddStationeryButton(context, stationeryList);
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
                        ...filteredList.map((item) {
                          return SingleItemCard(
                              id: item.id,
                              name: item.name,
                              quantity: item.quantity,
                              image: item.image,
                              demand: item.demand,
                              supply: item.supply,
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
}


