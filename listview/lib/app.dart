import 'package:flutter/material.dart';

import 'views/dashboar_view.dart';
import 'views/listview_seperated.dart';
import 'views/gridview_view.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'assignment 4',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboarView(),
        '/employees': (context) => const EmployeeListSeparatedView(),
        '/grid': (context) => const GridviewView(),
        // The assignment says dashboard buttons are listview/gridview.
        // We keep listview_view.dart as the employees screen entry.
        '/listview': (context) => const EmployeeListSeparatedView(),

      },
    );
  }
}

