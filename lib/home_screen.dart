import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloud_firestrore_database/view_users.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Firebase Corner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('Signup-Page');
                },
                child: const Text('Firebase Authentication.')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('view-users-screen');
                },
                child: const Text('Firestore Database'))
          ],
        ),
      )),
    );
  }
}
