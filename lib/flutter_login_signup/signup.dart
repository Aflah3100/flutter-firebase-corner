import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
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
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 18.0))),
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 18.0))),
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
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 18.0))),
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
                        onPressed: () {},
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
                          SizedBox(
                              height: 45,
                              width: 45,
                              child: Image.asset('assets/images/google.png')),
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset('assets/images/apple1.png')),
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
                            Navigator.of(context).popAndPushNamed('Login-Page');
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
