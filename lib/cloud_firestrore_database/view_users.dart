import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloud_firestrore_database/db/database.dart';
import 'package:flutter_firebase/cloud_firestrore_database/models/user_mode.dart';

class ViewUsersScreen extends StatelessWidget {
  const ViewUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Users',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FireStoreDb.instance.fetchAllUsers(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final currentUser =
                      UserModel.fromMap(snapshot.data!.docs[index].data());
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (){
                        FireStoreDb.instance.deleteUser(id: snapshot.data!.docs[index].id);
                      },
                      child: ListTile(
                        title: Center(child: Text(currentUser.firstName)),
                        subtitle: Center(child: Text(currentUser.lastName)),
                        leading: Text(currentUser.age.toString()),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) => const SizedBox(height: 5.0),
                itemCount: snapshot.data!.docs.length,
              );
            } else {
              return const Center(child: Text('No Users!'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, 'create-user-screen');
        },
        label: const Row(
          children: [Text('Create User'), Icon(Icons.add)],
        ),
      ),
    );
  }
}
