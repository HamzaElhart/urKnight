import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> signUpUser(
  String name,
  String email,
  String password,
  BuildContext context,
) async {
  print('[DEBUG] Starting signUpUser function');
  print('[DEBUG] Input - Name: $name, Email: $email');

  try {
    print('[DEBUG] Attempting to create user with email and password...');
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print('[DEBUG] User created successfully: ${userCredential.user?.uid}');

    print('[DEBUG] Storing user info in Firestore...');
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
          'name': name,
          'email': email,
          'createdAt':
              FieldValue.serverTimestamp(), // Optional: to track creation time
        });
    print('[DEBUG] User info stored in Firestore.');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully')),
    );
    print('[DEBUG] Account creation success snackbar shown.');

    // Navigate to login
    Navigator.pushReplacementNamed(context, '/login');
    print('[DEBUG] Navigated to /login route.');
  } on FirebaseAuthException catch (e) {
    print('[ERROR] FirebaseAuthException: ${e.code} - ${e.message}');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.message ?? 'Signup failed')));
  } catch (e) {
    print('[ERROR] Unexpected error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('An unexpected error occurred')),
    );
  }
}
