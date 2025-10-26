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
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_alt_rounded, size: 80, color: Colors.blue.shade900),
                const SizedBox(height: 16),
                Text(
                  "HRM System",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Sign in to continue",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                ),
                const SizedBox(height: 32),

                // Form card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),

                        PrimaryButton(
                          text: "Login",
                          onPressed: () {
                            if (emailController.text == adminEmail && passwordController.text == adminPassword) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const AdminDashboard()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Invalid email or password")),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  "Use admin@hrm.com / 12345",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
