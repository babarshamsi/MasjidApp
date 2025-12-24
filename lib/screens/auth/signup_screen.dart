import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var user;
  bool isLogin = true;

  Future<void> submit() async {
    if (checkIfEmptyFields(emailController.text, passwordController.text)) {
      return;
    }

      if (isLogin) {
        user = await authService.login(
          emailController.text,
          passwordController.text,
        );
      } else {
        user = await authService.signup(
          emailController.text,
          passwordController.text,
        );
      }

     navigateToHomeScreenOrShowError(user);
    }

    void navigateToHomeScreenOrShowError(user) {
      if (user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
      }
    }

    bool checkIfEmptyFields(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return true;
    }
    return false;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? "Login" : "Signup")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: Text(isLogin ? "Login" : "Signup"),
            ),
            TextButton(
              onPressed: () => setState(() => isLogin = !isLogin),
              child: Text(
                isLogin ? "Create account" : "Already have account? Login",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
