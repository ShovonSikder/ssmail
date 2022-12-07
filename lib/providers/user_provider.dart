//this file use to manage the state of user

import 'package:flutter/material.dart';
import 'package:ssmail/auth/auth_service.dart';
import 'package:ssmail/db/db_helper.dart';
import 'package:ssmail/models/email_model.dart';
import 'package:ssmail/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;

  getUserInfoByEmail() {
    DbHelper.getUserInfoByEmail(AuthService.currentUser!.email!)
        .listen((snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  Future<bool> doesUserExist(String email) async {
    return DbHelper.doesUserExist(email);
  }

  Future<void> addNewUser(UserModel userModel) =>
      DbHelper.addNewUser(userModel);

  Future<void> sendEmailTo(String toEmail, EmailModel emailModel) =>
      DbHelper.sendEmailTo(toEmail, emailModel);
}
