import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_firebase/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser({required String name}) async {
    final docUser = _db.collection('user').doc();

    final user = UserModel(id: docUser.id, name: name);

    await docUser.set(user.toJson());
  }

  Future updateUser({required String id, required String name}) async {
    final docUser = _db.collection('user').doc(id);

    await docUser.update({'name': name});
  }

  Future deleteUser({required String id}) async {
    final docUser = _db.collection('user').doc(id);

    await docUser.delete();
  }

  Future<UserModel?> getUser({required String id}) async {
    final snapshot = await _db.collection('user').doc(id).get();

    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }

    return null;
  }

  Future<List<UserModel>> getAllUser() async {
    final snapshot = await _db.collection('user').get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromJson(e.data())).toList();

    return userData;
  }

  Stream<List<UserModel>> readUsers() => _db.collection('user').snapshots().map(
      (event) => event.docs.map((e) => UserModel.fromJson(e.data())).toList());
}
