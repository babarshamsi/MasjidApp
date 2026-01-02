import 'package:aqimus_salah/models/auth_result_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AuthResult authResult;
  bool isLogin = true;

  Future<void> submit() async {
    if (checkIfEmptyFields(emailController.text, passwordController.text)) {
      return;
    }

    setState(() => isLoading = true);

    if (isLogin) {
      authResult = await authService.login(
        emailController.text,
        passwordController.text,
      );
    } else {
      authResult = await authService.signup(
        emailController.text,
        passwordController.text,
      );
    }

    setState(() => isLoading = false);

    // TODO need to check what is this
    if (!mounted) return;

    navigateToHomeScreenOrShowError(authResult);
  }

  void navigateToHomeScreenOrShowError(AuthResult authResult) {
    if (authResult.isSuccessful) {
      // Auth Wrapper is handling and listening to user stream
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authResult.errorMessage != null
                ? authResult.errorMessage!
                : "Something went wrong",
          ),
        ),
      );
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
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isLogin ? "Login" : "Signup", style: TextStyle(fontSize: 36,
                  fontWeight:
              FontWeight.bold),),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(border: OutlineInputBorder
                  (), hintText: "Email"),
              ),

              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(border: OutlineInputBorder
                  (), hintText: "Password"),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : submit,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(isLogin ? "Login" : "Signup"),
              ),
              SizedBox(height: 10,),

              TextButton(
                onPressed: () => setState(() => isLogin = !isLogin),
                child: Text(
                  isLogin ? "Create account" : "Already have account? Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
