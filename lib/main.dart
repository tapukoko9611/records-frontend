import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:records/blocs/employee/employee_bloc.dart';
import 'package:records/blocs/stationery/stationery_bloc.dart';
import 'package:records/repositories/employee_repository.dart';
import 'package:records/repositories/stationery_repository.dart';

import 'package:records/screens/employee/employee_list_screen.dart';
import 'package:records/screens/stationery/stationery_list_screen.dart';
import 'package:records/services/employee_api_client.dart';
import 'package:records/services/stationery_api_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final http.Client httpClient = http.Client();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => EmployeeRepository(employeeApiClient: EmployeeApiClient())),
        RepositoryProvider(create: (context) => StationeryRepository(stationeryApiClient: StationeryApiClient()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => EmployeeBloc(context.read<EmployeeRepository>())),
          BlocProvider(create: (context) => StationeryBloc(context.read<StationeryRepository>()))
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if(!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: StationeryListScreen()
          ),
        ),
      ),
    );
  }
}
