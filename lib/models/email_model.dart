import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssmail/models/user_model.dart';
import 'package:ssmail/utils/constants.dart';

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
    this.category = EmailCategories.primary,
    this.readStatus = false,
  });

  //method to automatically assign category to a email based on some general condition
  //email categorisation can be make more effective using ML model
  //by default the email will be in primary category
  void assignCategory() {
    //this are some static condition for email categorize
    //based on sender email address
    //the condition may improve even better to use ML model
    if (emailFrom.userEmail.contains('no-reply')) {
      category = EmailCategories.promotional;
    } else if (emailFrom.userEmail.contains('notification')) {
      category = EmailCategories.social;
    } else if (emailFrom.userEmail.contains('group')) {
      category = EmailCategories.forum;
    }
  }

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
