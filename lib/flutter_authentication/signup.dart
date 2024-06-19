import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/flutter_authentication/signin_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Controllers
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();

  //keys
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    const AuthWrapper();
  }

  //Register-User-To-Firebase-Function
  void registerUser() async {
    try {
      final email = emailTextController.text;
      final password = passwordController.text;
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
          const SnackBar(
              content: Text('User Registered Successfully',
                  style: TextStyle(fontSize: 20.0))));

      setState(() {
        nameTextController.text = "";
        emailTextController.text = "";
        passwordController.text = "";
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        ScaffoldMessenger.of(scaffoldKey.currentContext!)
            .showSnackBar(const SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Password Provided is too Weak",
                  style: TextStyle(fontSize: 18.0),
                )));
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(scaffoldKey.currentContext!)
            .showSnackBar(const SnackBar(
                backgroundColor: Colors.orangeAccent,
                content: Text(
                  "Account Already exits",
                  style: TextStyle(fontSize: 18.0),
                )));
      } else {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              e.code,
              style: const TextStyle(fontSize: 18.0),
            )));
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
                              controller: nameTextController,
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Enter Name'
                                      : null,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Name',
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
                              controller: emailTextController,
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Enter Email'
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

                        //Text form field container-3
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
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                      ? 'Enter Password'
                                      : null,
                              controller: passwordController,
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

                        //Sign-Up Button-Container
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
                              //Validate Crentials
                              if (formKey.currentState!.validate()) {
                                registerUser();
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
                              'Sign Up',
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

                        //Google-SignI-Row
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 160),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'google-sign-in-page');
                                },
                                child: SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: Image.asset(
                                        'assets/images/google.png')),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('otp-login-page');
                                },
                                child: const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Icon(Icons.phone_android_outlined)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        //Login-Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?",
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
                                    .popAndPushNamed('Login-Page');
                              },
                              child: const Text(
                                "LogIn",
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

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return SignInPage(
            displayName: snapshot.data!.email ?? "User",
          );
        } else {
          return const SignUpPage();
        }
      },
    );
  }
}
