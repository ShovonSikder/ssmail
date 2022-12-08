import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssmail/models/user_model.dart';

//fields name in database. Map's key also
const String emailFieldEmailId = 'emailId';
const String emailFieldEmailFrom = 'emailFrom';
const String emailFieldEmailTo = 'emailTo';
const String emailFieldEmailSendingTime = 'sendingTime';
const String emailFieldEmailSubject = 'emailSubject';
const String emailFieldEmailBody = 'emailBody';
const String emailFieldCategory = 'category';
const String emailFieldReadStatus = 'readStatus';

//email model class
class EmailModel {
  //properties
  String? emailId;
  UserModel emailFrom;
  String emailTo;
  Timestamp emailSendingTime;
  String? emailSubject; //subject can be null
  String? emailBody; //body can be null
  String category;
  bool readStatus;

  //constructor to create new email object
  EmailModel({
    this.emailId,
    required this.emailFrom,
    required this.emailTo,
    required this.emailSendingTime,
    this.emailSubject,
    this.emailBody,
    required this.category,
    this.readStatus = false,
  });

  //method to convert an object to a map.
  //Cause we have to pass data to database as map.
  Map<String, dynamic> toMap() => {
        emailFieldEmailFrom: emailFrom.toMap(),
        emailFieldEmailTo: emailTo,
        emailFieldEmailId: emailId,
        emailFieldEmailSendingTime: emailSendingTime,
        emailFieldEmailSubject: emailSubject,
        emailFieldEmailBody: emailBody,
        emailFieldCategory: category,
        emailFieldReadStatus: readStatus,
      };

  //factory method to convert a map to an object.
  //Cause we will use object in the whole app,
  //data returned from database is map so we have to convert it to an object
  factory EmailModel.fromMap(Map<String, dynamic> map) => EmailModel(
        emailId: map[emailFieldEmailId],
        emailFrom: UserModel.fromMap(map[emailFieldEmailFrom]),
        emailTo: map[emailFieldEmailTo],
        emailSendingTime: map[emailFieldEmailSendingTime],
        emailSubject: map[emailFieldEmailSubject],
        emailBody: map[emailFieldEmailBody],
        category: map[emailFieldCategory],
        readStatus: map[emailFieldReadStatus],
      );
}
