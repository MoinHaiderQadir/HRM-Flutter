import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';
import 'admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final adminEmail = "admin@hrm.com";
  final adminPassword = "12345";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1100;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 900 : 420),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 20, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('HRM System', style: TextStyle(color: Colors.blue.shade900, fontSize: isDesktop ? 28 : 22, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 6),
                              Text('Sign in to continue', style: TextStyle(color: Colors.grey.shade600)),
                            ],
                          ),
                        ),
                        if (isDesktop)
                          SizedBox(
                            width: 140,
                            child: Image.network(
                              'https://i.imgur.com/BoN9kdC.png',
                              // placeholder svg-ish image, optional - replace with asset later
                              height: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                    const SizedBox(height: 12),
                    TextField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                    const SizedBox(height: 18),
                    PrimaryButton(
                      text: 'Login',
                      onPressed: () {
                        if (emailController.text == adminEmail && passwordController.text == adminPassword) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AdminDashboard()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid credentials')));
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Text('Use admin@hrm.com / 12345', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
