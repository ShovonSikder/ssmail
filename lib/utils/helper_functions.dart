import 'package:flutter/material.dart';
import 'package:ssmail/utils/constants.dart';

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

String nameToPlaceholder(String firstName, String lastName) =>
    '${firstName[0]}${lastName[0]}'.toUpperCase();
