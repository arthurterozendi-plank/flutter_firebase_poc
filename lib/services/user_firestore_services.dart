import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_poc/models/user.dart';

class UserFirestoreService {
  UserFirestoreService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  static Future<UserModel?> getUser(String uid) async {
    final user = await _firestore.collection('users').doc(uid).get();
    return user.data() != null ? UserModel.fromJson(user.data()!) : null;
  }
}
