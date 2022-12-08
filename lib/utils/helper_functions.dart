import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ssmail/utils/constants.dart';

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

String nameToPlaceholder(String firstName, String lastName) =>
    '${firstName[0]}${lastName[0]}'.toUpperCase();

String getFormattedDate(DateTime dateTime) {
  String formattedDate = '';
  if (dateTime.year == DateTime.now().year) {
    if (dateTime.day == DateTime.now().day) {
      formattedDate = DateFormat('hh:mm a').format(dateTime);
    } else {
      formattedDate = '${dateTime.day} ${getMonthShortName(dateTime.month)}';
    }
  } else {
    formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  }

  return formattedDate;
}

String getMonthShortName(int month) {
  String shortName = '';
  switch (month) {
    case 1:
      shortName = 'Jan';
      break;
    case 2:
      shortName = 'Feb';
      break;
    case 3:
      shortName = 'Mar';
      break;
    case 4:
      shortName = 'Apr';
      break;
    case 5:
      shortName = 'May';
      break;
    case 6:
      shortName = 'Jun';
      break;
    case 7:
      shortName = 'Jul';
      break;
    case 8:
      shortName = 'Aug';
      break;
    case 9:
      shortName = 'Sep';
      break;
    case 10:
      shortName = 'Oct';
      break;
    case 11:
      shortName = 'Nov';
      break;
    case 12:
      shortName = 'Dec';
      break;
  }
  return shortName;
}
