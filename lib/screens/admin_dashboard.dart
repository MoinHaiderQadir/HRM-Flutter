import 'package:flutter/material.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/sidebar.dart';
import 'add_employee_screen.dart';
import 'employee_list_screen.dart';
import 'login_screen.dart';
import 'package:hive/hive.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // which content to show: 'home' | 'add' | 'list'
  String _active = 'home';

  void _onSelect(String key) {
    if (key == 'logout') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false);
      return;
    }
    setState(() {
      _active = key;
    });
  }

  Widget _mainContent(double width) {
    switch (_active) {
      case 'add':
        return const AddEmployeeScreen();
      case 'list':
        return const EmployeeListScreen();
      default:
        return _homeOverview(width);
    }
  }

  Widget _homeOverview(double width) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Admin', style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _statCard('Employees', 'Total:  ${_getEmployeeCount()}', Icons.people, width),
              _actionCard('Add Employee', Icons.person_add, () => _onSelect('add'), width),
              _actionCard('View Employees', Icons.list_alt, () => _onSelect('list'), width),
            ],
          ),
          const SizedBox(height: 24),
          Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.w600, fontSize: width * 0.03)),
          const SizedBox(height: 12),
          Card(
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Center(child: Text('No recent activity yet', style: TextStyle(color: Colors.grey.shade600))),
            ),
          ),
        ],
      ),
    );
  }

  int _getEmployeeCount() {
    // safe call to Hive box if exists
    try {
      final box = Hive.box('employeesBox');
      return box.length;
    } catch (_) {
      return 0;
    }
  }

  Widget _statCard(String title, String value, IconData icon, double width) {
    return SizedBox(
      width: (width > 900 ? 260 : width * 0.42),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: Colors.blue.shade900, child: Icon(icon, color: Colors.white)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(value, style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.bold)),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionCard(String title, IconData icon, VoidCallback onTap, double width) {
    return SizedBox(
      width: (width > 900 ? 260 : width * 0.42),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: Row(children: [
              CircleAvatar(backgroundColor: Colors.blue.shade900, radius: 20, child: Icon(icon, color: Colors.white)),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _scaffoldMobile(context),
      tablet: _scaffoldDesktopLike(context),
      desktop: _scaffoldDesktopLike(context),
    );
  }

  // Mobile uses drawer
  Widget _scaffoldMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      drawer: Drawer(child: Sidebar(onSelect: _onSelect)),
      body: _mainContent(MediaQuery.of(context).size.width),
    );
  }

  // Desktop / Tablet shows Sidebar + content
  Widget _scaffoldDesktopLike(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Sidebar(onSelect: _onSelect),
          Expanded(
            child: Column(
              children: [
                // top header
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Admin Dashboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      Row(children: [
                        CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Icon(Icons.person, color: Colors.white)),
                        const SizedBox(width: 8),
                        Text('Admin', style: TextStyle(fontWeight: FontWeight.w600)),
                      ])
                    ],
                  ),
                ),
                Expanded(child: _mainContent(width)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
