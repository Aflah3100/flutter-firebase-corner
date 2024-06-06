import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/flutter_login_signup/forgot_password.dart';
import 'package:flutter_firebase/flutter_login_signup/google_sigin_page.dart';
import 'package:flutter_firebase/flutter_login_signup/login.dart';
import 'package:flutter_firebase/flutter_login_signup/signin_screen.dart';
import 'package:flutter_firebase/flutter_login_signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-Firebase-Corner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      routes: {
        'Login-Page': (ctx) => const LoginPage(),
        'Signup-Page': (ctx) => const SignUpPage(),
        'forgot-password-page': (ctx) => const ForgotPasswordPage(),
        'google-sign-in-page': (ctx) => const GoogleSigninPage(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?> (
      stream:  FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return  SignInPage(displayName: snapshot.data!.email?? "User",);
        } else {
          return const SignUpPage();
        }
      },
    );
  }
}
