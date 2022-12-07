import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssmail/models/user_model.dart';

class DbHelper {
  static final _db = FirebaseFirestore.instance;
  static Future<bool> doesUserExist(String email) async {
    //check if there is a record of this email
    final snapshot = await _db.collection(collectionUser).doc(email).get();

    return snapshot.exists;
  }

  static Future<void> addNewUser(UserModel userModel) async {
    return await _db
        .collection(collectionUser)
        .doc(userModel.userEmail)
        .set(userModel.toMap());
  }
}
