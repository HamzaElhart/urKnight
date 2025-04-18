// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Show success message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signed in successfully!")));

      // Navigate to home screen and prevent going back to login/signup
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/onboarding_1', // Replace with your home screen route
        (route) =>
            false, // Removes all previous routes (including login/signup)
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed: ${e.toString()}")));
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
