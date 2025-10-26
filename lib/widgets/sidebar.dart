import 'package:flutter/material.dart';
import '../screens/add_employee_screen.dart';
import '../screens/employee_list_screen.dart';

class Sidebar extends StatelessWidget {
  final String title;
  final Function(String) onSelect;
  const Sidebar({super.key, required this.onSelect, this.title = 'Admin'});

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue.shade900;
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HRM',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color),
          ),
          const SizedBox(height: 6),
          Text('$title Panel', style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          _item(context, icon: Icons.person_add, label: 'Add Employee', key: 'add'),
          _item(context, icon: Icons.list_alt, label: 'Employee List', key: 'list'),
          _item(context, icon: Icons.logout, label: 'Logout', key: 'logout'),
          const Spacer(),
          const Divider(),
          const SizedBox(height: 12),
          Text('© HRM', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, {required IconData icon, required String label, required String key}) {
    final color = Colors.blue.shade900;
    return InkWell(
      onTap: () => onSelect(key),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
