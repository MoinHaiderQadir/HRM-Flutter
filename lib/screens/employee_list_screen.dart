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
      backgroundColor: Colors.grey.shade100,
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

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: employees.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final emp = employees.getAt(index)!;

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.blue.shade900,
                    child: Text(
                      emp.name.isNotEmpty ? emp.name[0].toUpperCase() : "?",
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    emp.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(emp.designation, style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text(emp.phone, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    ],
                  ),

                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditEmployeeScreen(index: index, employee: emp),
                          ),
                        );
                      } else if (value == 'delete') {
                        employees.deleteAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Employee Deleted")),
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text("Edit")),
                      const PopupMenuItem(value: 'delete', child: Text("Delete")),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
