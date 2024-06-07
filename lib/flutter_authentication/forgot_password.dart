import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Firebase reset password function
  void resetPassword() async {
    try {
      final email = emailController.text;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text('If email Registered, Reset-Link has been sent',
                  style: TextStyle(fontSize: 20.0, color: Colors.white))));
      setState(() {
        emailController.text = "";
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Error: ${e.code}",
            style: const TextStyle(fontSize: 18.0),
          )));
    }
  }

  // Controllers
  final emailController = TextEditingController();

  // Keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Password Recovery',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Enter your email',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40.0,
            ),
            // Expanded container
            Expanded(
                child: Column(
              children: [
                // Email form field
                Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: emailController,
                        validator: (email) => (email == null || email.isEmpty)
                            ? 'Enter email address'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                      ),
                    )),
                const SizedBox(
                  height: 40.0,
                ),
                // Send email button
                Container(
                  width: width,
                  height: height * .06,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white),
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        resetPassword();
                      }
                    },
                    child: const Center(
                        child: Text(
                      'Send Email',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                // Create account row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).popAndPushNamed('signup-page');
                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(
                            color: Color.fromARGB(225, 184, 166, 6),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      )),
    );
  }
}
