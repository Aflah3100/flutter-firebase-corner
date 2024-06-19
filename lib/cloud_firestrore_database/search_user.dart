import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloud_firestrore_database/db/database.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  // State variables
  Future<QuerySnapshot>? searchResults;

  // Form keys
  final formKey1 = GlobalKey<FormState>();

  // Controllers
  final nameSearchController = TextEditingController();

  @override
  void dispose() {
    nameSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    final width = MediaQuery.of(context).size.width;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Search User',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Textfield
                const Center(
                  child: Text(
                    'Search User Below',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Search Container
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  width: width,
                  height: 50.0, // Fixed height
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Form(
                    key: formKey1,
                    child: TextFormField(
                      controller: nameSearchController,
                      validator: (name) => (name == null || name.isEmpty) ? 'Enter a Name' : null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter First Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Search User Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey1.currentState!.validate()) {
                        setState(() {
                          searchResults = FireStoreDb.instance.fetchUserByName(name: nameSearchController.text);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 2.0,
                    ),
                    child: const Text(
                      'Search User',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Search Results
                if (searchResults != null)
                  FutureBuilder<QuerySnapshot>(
                    future: searchResults,
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            var userDoc = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: (){
                                FireStoreDb.instance.updateUserAge(id: userDoc.id, newAge: 23);
                              },
                              child: ListTile(
                                title: Text(userDoc["FirstName"]),
                                subtitle: Text(userDoc["LastName"]),
                                leading: Text(userDoc["Age"].toString()),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      } else {
                        return const Center(
                          child: Text('No Users Found'),
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
