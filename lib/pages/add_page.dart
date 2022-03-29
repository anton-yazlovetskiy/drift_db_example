import 'package:drift_db_example/data/local/db/app_db.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  late AppDb _db;
  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _dateController.dispose();
    _db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text('Name')),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(label: Text('Last Name')),
            ),
            TextFormField(
              controller: _dateController,
              keyboardType: TextInputType.none,
              decoration: const InputDecoration(label: Text('Select date')),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'cannot be empty' : null,
              onTap: () => _pickDate(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final entity = EmployeeCompanion(
              userName: drift.Value(_nameController.text),
              lastName: drift.Value(_lastNameController.text),
              dateOfBirth: drift.Value(DateTime.now()));
          _db.insertEmployee(entity).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added new user'),
                  ),
                ),
              );

          _nameController.clear();
          _lastNameController.clear();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickDate(context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? const Text(''),
      ),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      String dob = DateFormat('dd.MM.yyyy').format(newDate);
      _dateController.text = dob;
    });
  }
}
