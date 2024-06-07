import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/flutter_authentication/signin_screen.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key, required this.verificationId});

  final String verificationId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    //keys
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final otpController = TextEditingController();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'OTP Verification',
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
                    controller: otpController,
                    validator: (phNumber) =>
                        (phNumber == null || phNumber.isEmpty)
                            ? "Enter OTP"
                            : null,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone_android),
                        hintText: 'OTP'),
                  )),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      final userCredential = PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);
                      await FirebaseAuth.instance
                          .signInWithCredential(userCredential);
                      Navigator.of(scaffoldKey.currentContext!).pushReplacement(
                          MaterialPageRoute(
                              builder: (ctx) =>
                                  SignInPage(displayName: 'Display Name')));
                    } catch (e) {
                      ScaffoldMessenger.of(scaffoldKey.currentContext!)
                          .showSnackBar(SnackBar(
                        content: Text('Verification failed: ${e.toString()}'),
                      ));
                    }
                  }
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.white10),
                child: const Text(
                  'Verify OTP',
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
