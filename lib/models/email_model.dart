import 'package:ssmail/models/user_model.dart';

//fields name in database. Map's key also
const String emailFieldEmailFrom = 'emailFrom';
const String emailFieldEmailSendingTime = 'sendingTime';
const String emailFieldEmailSubject = 'emailSubject';
const String emailFieldEmailBody = 'emailBody';

//email model class
class EmailModel {
  UserModel emailFrom;
  String emailSendingTime;
  String emailSubject;
  String emailBody;

  //constructor to create new email object
  EmailModel({
    required this.emailFrom,
    required this.emailSendingTime,
    required this.emailSubject,
    required this.emailBody,
  });

  //method to convert an object to a map.
  //Cause we have to pass data to database as map.
  Map<String, dynamic> toMap() => {};

  //factory method to convert a map to an object.
  //Cause we will use object in the whole app,
  //data returned from database is map so we have to convert it to an object
  factory EmailModel.fromMap(Map<String, dynamic> map) => EmailModel(
        emailFrom: map[emailFieldEmailFrom],
        emailSendingTime: map[emailFieldEmailSendingTime],
        emailSubject: map[emailFieldEmailSubject],
        emailBody: map[emailFieldEmailBody],
      );
}
