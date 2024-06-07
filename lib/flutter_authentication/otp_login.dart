import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/flutter_authentication/otp_verification.dart';
import 'package:flutter_firebase/flutter_authentication/signin_screen.dart';

class OtpLoginPage extends StatelessWidget {
  const OtpLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    // Keys
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final phoneNumberController = TextEditingController();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Login With Phone',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 224, 221, 221),
                  borderRadius: BorderRadius.circular(20.0)),
              width: width,
              height: height * 0.07,
              child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: phoneNumberController,
                    validator: (phNumber) =>
                        (phNumber == null || phNumber.isEmpty)
                            ? "Enter Mobile Number"
                            : (phNumber.length < 10)
                                ? 'Enter valid phone number'
                                : null,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone_android),
                        hintText: 'Mobile number'),
                  )),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted:
                          (PhoneAuthCredential userCredential) async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(userCredential);
                          Navigator.of(scaffoldKey.currentContext!)
                              .pushReplacement(
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    SignInPage(displayName: 'Display Name')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(scaffoldKey.currentContext!)
                              .showSnackBar(SnackBar(
                            content:
                                Text('Verification failed: ${e.toString()}'),
                          ));
                        }
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        ScaffoldMessenger.of(scaffoldKey.currentContext!)
                            .showSnackBar(SnackBar(
                          content: Text('Verification failed: ${e.message}'),
                        ));
                      },
                      codeSent:
                          (String verificationId, int? forceResendingToken) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => OtpVerificationPage(
                                    verificationId: verificationId)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        ScaffoldMessenger.of(scaffoldKey.currentContext!)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Auto-retrieval timed out. Please enter the OTP manually.'),
                        ));
                      },
                    );
                  }
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.white10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))
          ],
        ),
      )),
    );
  }
}
