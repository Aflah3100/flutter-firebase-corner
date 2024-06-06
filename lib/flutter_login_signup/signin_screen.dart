import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  String displayName;
  SignInPage({super.key, required this.displayName});

//Sign-Out-Firebase-Function
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(child: Text("Welcome $displayName")),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await signOut();

            Navigator.of(context).popAndPushNamed('Signup-Page');
          },
          label: const Text('Sign Out')),
    );
  }
}
