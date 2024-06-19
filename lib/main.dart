import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloud_firestrore_database/create_user.dart';
import 'package:flutter_firebase/cloud_firestrore_database/search_user.dart';
import 'package:flutter_firebase/cloud_firestrore_database/view_users.dart';
import 'package:flutter_firebase/flutter_authentication/forgot_password.dart';
import 'package:flutter_firebase/flutter_authentication/google_sigin_page.dart';
import 'package:flutter_firebase/flutter_authentication/login.dart';
import 'package:flutter_firebase/flutter_authentication/otp_login.dart';
import 'package:flutter_firebase/flutter_authentication/signup.dart';
import 'package:flutter_firebase/home_screen.dart';

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
      home: const HomeScreen(),
      routes: {
        'Login-Page': (ctx) => const LoginPage(),
        'Signup-Page': (ctx) => const SignUpPage(),
        'forgot-password-page': (ctx) => const ForgotPasswordPage(),
        'google-sign-in-page': (ctx) => const GoogleSigninPage(),
        'otp-login-page': (ctx) => const OtpLoginPage(),
        'create-user-screen': (ctx) => const CreateUserScreen(),
        'search-user-screen': (ctx) => const SearchUserScreen(),
        'view-users-screen': (ctx) => const ViewUsersScreen()
      },
    );
  }
}
