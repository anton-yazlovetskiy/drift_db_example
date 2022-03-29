import 'package:drift_db_example/pages/add_page.dart';
import 'package:drift_db_example/pages/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: const MainPage(),
      routes: {
        '/main': (context) => const MainPage(),
        '/add': (context) => const AddPage(),
        '/edit': (context) => const MainPage(),
      },
      initialRoute: '/main',
    );
  }
}
