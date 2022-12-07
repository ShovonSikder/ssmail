//this file use to manage the state of user

import 'package:flutter/material.dart';
import 'package:ssmail/db/db_helper.dart';
import 'package:ssmail/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  Future<bool> doesUserExist(String email) async {
    return DbHelper.doesUserExist(email);
  }

  Future<void> addNewUser(UserModel userModel) =>
      DbHelper.addNewUser(userModel);
}
