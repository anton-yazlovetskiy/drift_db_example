import 'package:drift_db_example/data/local/db/app_db.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late AppDb _db;

  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    super.dispose();
    _db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of items'),
      ),
      body: FutureBuilder<List<EmployeeData>>(
          future: _db.getEmployees(),
          builder: (context, snaphot) {
            if (snaphot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (snaphot.hasData) {
              final List<EmployeeData>? _listUsers = snaphot.data;
              if (_listUsers != null) {
                return ListView.builder(
                  itemCount: _listUsers.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(_listUsers[index].userName),
                      subtitle: Text(_listUsers[index].dateOfBirth.toString()),
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('list users void'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
