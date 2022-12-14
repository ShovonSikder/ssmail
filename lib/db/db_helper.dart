import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssmail/models/email_model.dart';
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

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfoByEmail(
      String email) {
    return _db.collection(collectionUser).doc(email).snapshots();
  }

  static Future<void> sendEmailTo(String toEmail, EmailModel emailModel) async {
    final wb = _db.batch();
    final newDocInbox = _db
        .collection(collectionUser)
        .doc(toEmail)
        .collection(collectionUserInbox)
        .doc();

    emailModel.emailId = newDocInbox.id;
    wb.set(
      newDocInbox,
      emailModel.toMap(),
    );

    wb.set(
      _db
          .collection(collectionUser)
          .doc(emailModel.emailFrom.userEmail)
          .collection(collectionUserSentBox)
          .doc(emailModel.emailId),
      emailModel.toMap(),
    );

    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllInboxMailsByEmail(
          String email) =>
      _db
          .collection(collectionUser)
          .doc(email)
          .collection(collectionUserInbox)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSentBoxMailsByEmail(
          String email) =>
      _db
          .collection(collectionUser)
          .doc(email)
          .collection(collectionUserSentBox)
          .snapshots();

  static Future<void> updateEmailField(
          String userEmail, String emailId, Map<String, dynamic> data) =>
      _db
          .collection(collectionUser)
          .doc(userEmail)
          .collection(collectionUserInbox)
          .doc(emailId)
          .update(data);
}
