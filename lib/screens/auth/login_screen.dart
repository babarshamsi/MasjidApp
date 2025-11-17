

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  login() async {
    setState(() {
      loading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text);

      Navigator.pushReplacementNamed(context, '/home');
    }
    catch (execption) {
      print(execption);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Failed: ${execption.toString()}'),
      ));

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Masjid App Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),

              TextField(
                  controller: email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                  )
              ),
              const SizedBox(height: 20,),

              TextField(controller:
              password, obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),),

              const SizedBox(height: 20,),

              ElevatedButton(onPressed: loading ? null : login,
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text("Login")),

              TextButton(onPressed: () {
                Navigator.pushNamed(context, '/signup');
              }, child: const Text("Create account")),
            ]),
      ),
    ),
    );
  }
}
