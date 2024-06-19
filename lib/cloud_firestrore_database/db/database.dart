import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/cloud_firestrore_database/models/user_mode.dart';

class FireStoreDb {
  // Singleton
  FireStoreDb._internal();
  static final FireStoreDb instance = FireStoreDb._internal();
  factory FireStoreDb() {
    return instance;
  }

  Future<void> addUserDetails(UserModel user) async {
    await FirebaseFirestore.instance.collection('User').doc().set(user.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
    return FirebaseFirestore.instance.collection('User').snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUserByName(
      {required String name}) async {
    return await FirebaseFirestore.instance
        .collection('User')
        .where('FirstName', isEqualTo: name)
        .get();
  }

  Future<void> updateUserAge({required String id, required int newAge}) async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .update({"Age": newAge});
  }

  Future<void> deleteUser({required String id}) async {
    await FirebaseFirestore.instance.collection('User').doc(id).delete();
  }
}
