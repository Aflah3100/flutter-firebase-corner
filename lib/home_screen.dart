import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Firebase Corner'),
      centerTitle: true,
      
      ),

      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
        
            ElevatedButton(onPressed: (){}, child: const Text('Firebase Authentication (Login &Signup)'))
          ],
        
        ),
      )),
    );
  }
}