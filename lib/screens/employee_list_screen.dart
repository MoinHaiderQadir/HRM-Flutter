import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/employee_model.dart';
import 'edit_employee_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Employee>('employeesBox');

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Employee> employees, _) {
          if (employees.isEmpty) {
            return const Center(
              child: Text(
                "No Employees Added Yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingTextStyle: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columns: const [
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Phone")),
                        DataColumn(label: Text("Designation")),
                        DataColumn(label: Text("Salary")),
                        DataColumn(label: Text("Actions")),
                      ],
                      rows: List.generate(employees.length, (index) {
                        final emp = employees.getAt(index)!;

                        return DataRow(cells: [
                          DataCell(Text(emp.name)),
                          DataCell(Text(emp.email)),
                          DataCell(Text(emp.phone)),
                          DataCell(Text(emp.designation)),
                          DataCell(Text(emp.salary.toString())),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => EditEmployeeScreen(index: index, employee: emp),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    employees.deleteAt(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Employee Deleted")),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
