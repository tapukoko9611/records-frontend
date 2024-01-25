import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:records/blocs/employee/employee_bloc.dart';
import 'package:records/blocs/stationery/stationery_bloc.dart';
import 'package:records/blocs/transaction/transaction_bloc.dart';
import 'package:records/repositories/employee_repository.dart';
import 'package:records/repositories/stationery_repository.dart';
import 'package:records/repositories/transaction_repository.dart';

import 'package:records/screens/employee/employee_list_screen.dart';
import 'package:records/screens/stationery/stationery_list_screen.dart';
import 'package:records/screens/transaction/transaction_list.dart';
import 'package:records/services/employee_api_client.dart';
import 'package:records/services/stationery_api_client.dart';
import 'package:records/services/transaction_api_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final _list = <Widget>[
    const EmployeeListScreen(),
    const StationeryListScreen(),
    const TransactionListScreen()
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // final http.Client httpClient = http.Client();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => EmployeeRepository(employeeApiClient: EmployeeApiClient())),
        RepositoryProvider(create: (context) => StationeryRepository(stationeryApiClient: StationeryApiClient())),
        RepositoryProvider(create: (context) => TransactionRepository(transactionApiClient: TransactionApiClient()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => EmployeeBloc(context.read<EmployeeRepository>())),
          BlocProvider(create: (context) => StationeryBloc(context.read<StationeryRepository>())),
          BlocProvider(create: (context) => TransactionBloc(context.read<TransactionRepository>()))
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if(!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: Scaffold(
              // body: _list[_index],
              body: IndexedStack(
                index: _index,
                children: _list,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Employees", ),
                  BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Stationery", ),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Transactions", ),
                ],
                currentIndex: _index,
                onTap: (int index) {
                  setState(() {
                    setState(() {
                      _index = index;
                    });
                  });
                },
                elevation: 0,

                selectedFontSize: 15,
                selectedItemColor: Colors.amberAccent,
                selectedIconTheme: const IconThemeData(color: Colors.amberAccent, size: 25),
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

                unselectedFontSize: 10,
                unselectedIconTheme: const IconThemeData(size: 15),
                unselectedItemColor: Colors.black,
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                // type: BottomNavigationBarType.shifting,
              ),
            )
          ),
        ),
      ),
    );
  }
}
