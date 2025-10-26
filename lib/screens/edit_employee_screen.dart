import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/employee_model.dart';
import '../widgets/primary_button.dart';

class EditEmployeeScreen extends StatefulWidget {
  final int index;
  final Employee employee;

  const EditEmployeeScreen({super.key, required this.index, required this.employee});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController designationController;
  late TextEditingController salaryController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.employee.name);
    emailController = TextEditingController(text: widget.employee.email);
    phoneController = TextEditingController(text: widget.employee.phone);
    designationController = TextEditingController(text: widget.employee.designation);
    salaryController = TextEditingController(text: widget.employee.salary.toString());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Employee"),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            margin: const EdgeInsets.all(28),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 40 : 20,
                vertical: 32,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _field("Name", nameController),
                    _field("Email", emailController),
                    _field("Phone", phoneController),
                    _field("Designation", designationController),
                    _field("Salary", salaryController, TextInputType.number),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: "Update Employee",
                      onPressed: _updateEmployee,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller, [TextInputType type = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  void _updateEmployee() {
    widget.employee.name = nameController.text;
    widget.employee.email = emailController.text;
    widget.employee.phone = phoneController.text;
    widget.employee.designation = designationController.text;
    widget.employee.salary = double.tryParse(salaryController.text) ?? 0;

    Hive.box<Employee>("employeesBox").putAt(widget.index, widget.employee);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Employee Updated Successfully")),
    );

    Navigator.pop(context);
  }
}
