import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/flutter_authentication/signin_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class GoogleSigninPage extends StatefulWidget {
  const GoogleSigninPage({super.key});

  @override
  State<GoogleSigninPage> createState() => _GoogleSigninPageState();
}

class _GoogleSigninPageState extends State<GoogleSigninPage> {
  //User instance
  User? user;

  //FirebaseAuth Instance
  final _auth = FirebaseAuth.instance;

  //Google-Sign-In-function
  Future<void> googleSignIn() async {
    try {

      // Initialize Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Start the sign-in process
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Check if the sign-in was successful
      if (googleUser != null) {
        // Obtain authentication details from the signed-in Google user
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a credential using the authentication details
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        // Check if the user is not null
        if (user != null) {
          // Create a user information map
          final Map<String, dynamic> userInfoMap = {
            "email": user.email,
            "name": user.displayName,
            "imgUrl": user.photoURL,
            "id": user.uid,
          };

          // Save the user information to Firestore
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .set(userInfoMap);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _auth.authStateChanges().listen((userEvent) {
      setState(() {
        user = userEvent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google-Sign-In'),
        centerTitle: true,
      ),
      body: Center(
          child: (user == null) ? _googleSignInButton() : SignInPage(displayName: user!.displayName!)),
    );
  }

  //Functions
  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        width: 200.0,
        height: 50.0,
        child: SignInButton(
          Buttons.google,
          text: 'Sign In With Google',
          onPressed: () {
            googleSignIn();
          },
        ),
      ),
    );
  }

  
}
