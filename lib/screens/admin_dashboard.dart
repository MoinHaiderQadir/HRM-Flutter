import 'package:flutter/material.dart';
import 'add_employee_screen.dart';
import 'employee_list_screen.dart';
import '../widgets/primary_button.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  final pages = const [
    _HomePage(),
    AddEmployeeScreen(),
    EmployeeListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: pages[_currentIndex],

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Employees"),
        ],
      ),
    );
  }
}

// Home Overview Page
class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Admin',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900)),
          const SizedBox(height: 18),

          _dashboardCard(
            context,
            icon: Icons.people,
            title: "Manage Employees",
            subtitle: "View, Edit & Remove Employees",
          ),
          const SizedBox(height: 16),
          _dashboardCard(
            context,
            icon: Icons.person_add,
            title: "Add Employee",
            subtitle: "Register new employee quickly",
          ),
          const SizedBox(height: 16),
          _dashboardCard(
            context,
            icon: Icons.settings,
            title: "System Settings",
            subtitle: "Coming Soon...",
          ),
        ],
      ),
    );
  }

  Widget _dashboardCard(BuildContext context,
      {required IconData icon, required String title, required String subtitle}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
