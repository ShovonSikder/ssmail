import 'package:flutter/material.dart';
import 'package:ssmail/customwidget/text_profile_placeholder.dart';
import 'package:ssmail/models/email_model.dart';
import 'package:ssmail/pages/email_read_page.dart';
import 'package:ssmail/utils/constants.dart';
import 'package:ssmail/utils/helper_functions.dart';

class EmailListTile extends StatelessWidget {
  final EmailModel email;
  final String emailBox;
  const EmailListTile(
      {Key? key, required this.email, this.emailBox = EmailBox.inbox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, EmailReadPage.routeName,
            arguments: [email, emailBox == EmailBox.inbox]);
      },
      leading: TextProfilePlaceholder(
        text: emailBox == EmailBox.sentBox
            ? email.emailTo[0].toUpperCase()
            : nameToPlaceholder(
                email.emailFrom.userFirstName,
                email.emailFrom.userLastName,
              ),
        bgColor: Colors.greenAccent,
      ),
      title: Text(
        emailBox != EmailBox.sentBox
            ? '${email.emailFrom.userFirstName} ${email.emailFrom.userLastName}'
            : 'To: ${email.emailTo}',
        style: TextStyle(
          fontWeight: emailBox != EmailBox.sentBox && !email.readStatus
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            email.emailSubject != null && email.emailSubject!.isNotEmpty
                ? (email.emailSubject!.length > 25
                    ? '${email.emailSubject!.substring(0, 25)} ...'
                    : email.emailSubject!)
                : '(No Subject)',
            style: TextStyle(
                fontWeight: emailBox != EmailBox.sentBox && !email.readStatus
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          Text(
            email.emailBody != null && email.emailBody!.isNotEmpty
                ? (email.emailBody!.length > 25
                    ? '${email.emailBody!.replaceAll('\n', ' ').substring(0, 25)} ...'
                    : email.emailBody!.replaceAll('\n', ' '))
                : '',
            style: TextStyle(
                fontWeight: emailBox != EmailBox.sentBox && !email.readStatus
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ],
      ),
      trailing: Text(
        getFormattedDate(
          email.emailSendingTime.toDate(),
        ),
        style: TextStyle(
            fontWeight: emailBox != EmailBox.sentBox && !email.readStatus
                ? FontWeight.bold
                : FontWeight.normal),
      ),
      isThreeLine: true,
    );
  }
}
