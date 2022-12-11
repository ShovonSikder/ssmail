//this file use to manage the state of user

import 'package:flutter/material.dart';
import 'package:ssmail/auth/auth_service.dart';
import 'package:ssmail/db/db_helper.dart';
import 'package:ssmail/models/email_model.dart';
import 'package:ssmail/models/user_model.dart';
import 'package:ssmail/utils/constants.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  List<EmailModel> inbox = [];
  List<EmailModel> sentBox = [];

  getAllInboxMailsByEmail() {
    DbHelper.getAllInboxMailsByEmail(AuthService.currentUser!.email!)
        .listen((snapshot) {
      inbox = List.generate(
        snapshot.docs.length,
        (index) => EmailModel.fromMap(
          snapshot.docs[index].data(),
        ),
      );
      inbox.sort(
        (e1, e2) => e2.emailSendingTime.compareTo(e1.emailSendingTime),
      );
      notifyListeners();
    });
  }

  getAllSentBoxMailsByEmail() {
    DbHelper.getAllSentBoxMailsByEmail(AuthService.currentUser!.email!)
        .listen((snapshot) {
      sentBox = List.generate(
        snapshot.docs.length,
        (index) => EmailModel.fromMap(
          snapshot.docs[index].data(),
        ),
      );
      sentBox.sort(
        (e1, e2) => e2.emailSendingTime.compareTo(e1.emailSendingTime),
      );
      notifyListeners();
    });
  }

  getUserInfoByEmail() {
    DbHelper.getUserInfoByEmail(AuthService.currentUser!.email!)
        .listen((snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  Map<String, int> countUnreadEmail() {
    Map<String, int> countMap = {
      EmailCategories.primary: 0,
      EmailCategories.promotional: 0,
      EmailCategories.social: 0,
      EmailCategories.forum: 0,
    };
    for (var email in inbox) {
      if (!email.readStatus) {
        countMap[email.category] = countMap[email.category]! + 1;
      }
    }
    return countMap;
  }

  Future<bool> doesUserExist(String email) async {
    return DbHelper.doesUserExist(email);
  }

  Future<void> addNewUser(UserModel userModel) =>
      DbHelper.addNewUser(userModel);

  Future<void> sendEmailTo(String toEmail, EmailModel emailModel) =>
      DbHelper.sendEmailTo(toEmail, emailModel);

  Future<void> updateEmailField(
          String emailId, String field, dynamic value) async =>
      await DbHelper.updateEmailField(
          AuthService.currentUser!.email!, emailId, {field: value});
}
