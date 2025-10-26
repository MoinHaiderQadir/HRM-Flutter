import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/employee_model.dart';
import '../widgets/primary_button.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final designationController = TextEditingController();
  final salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1000;

    final form = Column(
      children: [
        _field("Name", nameController),
        _field("Email", emailController),
        _field("Phone", phoneController),
        _field("Designation", designationController),
        _field("Salary", salaryController, TextInputType.number),
        const SizedBox(height: 20),
        PrimaryButton(
          text: "Save Employee",
          onPressed: _saveEmployee,
        ),
      ],
    );

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isDesktop ? 600 : 400),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(padding: const EdgeInsets.all(24), child: form),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c, [TextInputType? type]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: c,
        keyboardType: type ?? TextInputType.text,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  void _saveEmployee() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        designationController.text.isEmpty ||
        salaryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final employee = Employee(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      designation: designationController.text,
      salary: double.tryParse(salaryController.text) ?? 0,
    );

    Hive.box<Employee>('employeesBox').add(employee);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Employee Added Successfully")),
    );

    nameController.clear();
    emailController.clear();
    phoneController.clear();
    designationController.clear();
    salaryController.clear();
  }
}
