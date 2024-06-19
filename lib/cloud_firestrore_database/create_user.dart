import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloud_firestrore_database/db/database.dart';
import 'package:flutter_firebase/cloud_firestrore_database/models/user_mode.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  // State variables
  Future<QuerySnapshot>? searchResults;

  // Form key
  final formKey = GlobalKey<FormState>();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create User',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Name Text
                  const Text(
                    'First Name',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),

                  // First Name TextFormField
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                    width: width,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: firstNameController,
                      validator: (name) => (name == null || name.isEmpty) ? 'Enter First Name' : null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your First Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Last Name Text
                  const Text(
                    'Last Name',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),

                  // Last Name TextFormField
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                    width: width,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: lastNameController,
                      validator: (name) => (name == null || name.isEmpty) ? 'Enter Last Name' : null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your Last Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Age Text
                  const Text(
                    'Age',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),

                  // Age TextFormField
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                    width: width,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextFormField(
                      controller: ageController,
                      validator: (age) => (age == null || age.isEmpty) ? 'Enter Age' : null,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your Age',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),

                  // Create User Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final user = UserModel(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            age: int.parse(ageController.text),
                          );
                          await FireStoreDb.instance.addUserDetails(user);
                          Fluttertoast.showToast(
                            msg: "User Added Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          setState(() {
                            firstNameController.text = "";
                            lastNameController.text = "";
                            ageController.text = "";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 2.0,
                      ),
                      child: const Text(
                        'Create User',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),

                  // Search User Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamed('search-user-screen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 175, 76, 144),
                        elevation: 2.0,
                      ),
                      child: const Text(
                        'Search User',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
