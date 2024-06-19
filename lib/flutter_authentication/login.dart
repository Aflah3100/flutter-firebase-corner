import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/flutter_authentication/signin_screen.dart';
import 'package:flutter_firebase/flutter_authentication/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  
  //Controllers
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();

  //keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();



  //Login-User-with-Firebase

  void loginUser() async {
    try {
      final email = emailTextController.text;
      final password = passwordController.text;
      // Await the sign-in attempt
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // If sign-in was successful, show the success message
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text('User Logged In Successfully',
                  style: TextStyle(fontSize: 20.0))));
      setState(() {
        emailTextController.text = "";
        passwordController.text = "";
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text("No User found with this email",
                    style: TextStyle(fontSize: 18.0))));
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.redAccent,
                content:
                    Text("Wrong Password", style: TextStyle(fontSize: 18.0))));
      } else {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Error: ${e.code}",
                style: const TextStyle(fontSize: 18.0))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(
          children: [
            //Image-Container
            SizedBox(
                width: width,
                height: height * 0.30,
                child: Image.asset('assets/images/car.jpeg')),
            SizedBox(
              height: height * .10,
            ),

            //Text-Form & Buttons
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //Text form field container-1
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          width: width,
                          height: height * 0.05,
                          decoration: const BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: TextFormField(
                              controller: emailTextController,
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Enter Name'
                                      : null,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf),
                                      fontSize: 18.0))),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),

                        //Text form field container-2
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          width: width,
                          height: height * 0.05,
                          decoration: const BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: TextFormField(
                              controller: passwordController,
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Enter Password'
                                      : null,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf),
                                      fontSize: 18.0))),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),

                        //Forgot Password Text Button
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('forgot-password-page');
                          },
                          child: const Text("Forgot Password?",
                              style: TextStyle(
                                  color: Color(0xFF8c8e98),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),

                        //Login Button-Container
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          width: width,
                          height: height * 0.05,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginUser();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SignInPage(
                                        displayName:
                                            emailTextController.text)));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF273671)),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        // Or Login with Text
                        const Text(
                          "or LogIn with",
                          style: TextStyle(
                              color: Color(0xFF273671),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        //Google-Sign-Row
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 160),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  height: 45,
                                  width: 45,
                                  child:
                                      Image.asset('assets/images/google.png')),
                              SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('otp-login-page');
                                    },
                                    child: const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child:  Icon(
                                            Icons.phone_android_outlined)),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        //Sign Up Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Dont have an account",
                                style: TextStyle(
                                    color: Color(0xFF8c8e98),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .popAndPushNamed('Signup-Page');
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Color(0xFF273671),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

