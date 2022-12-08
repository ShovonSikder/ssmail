import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ssmail/customwidget/text_profile_placeholder.dart';
import 'package:ssmail/models/email_model.dart';
import 'package:ssmail/providers/user_provider.dart';
import 'package:ssmail/utils/helper_functions.dart';

class EmailReadPage extends StatefulWidget {
  static const String routeName = '/email_read';
  const EmailReadPage({Key? key}) : super(key: key);

  @override
  State<EmailReadPage> createState() => _EmailReadPageState();
}

class _EmailReadPageState extends State<EmailReadPage> {
  late bool inboxMail;
  late EmailModel emailModel;
  bool showMore = false;

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    emailModel = argList[0] as EmailModel;
    inboxMail = argList[1] as bool;
    if (inboxMail) {
      Provider.of<UserProvider>(context, listen: false)
          .updateEmailField(emailModel.emailId!, emailFieldReadStatus, true);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build email read page');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          buildSubjectSection(emailModel),
          const SizedBox(
            height: 10,
          ),
          buildUserInfoListTile(emailModel),
          if (showMore) buildMoreInfo(),
          const SizedBox(
            height: 15,
          ),
          buildEmailBodySection(emailModel),
        ],
      ),
    );
  }

  Widget buildMoreInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${emailModel.emailFrom.userEmail}'),
            Text('To:      ${emailModel.emailTo}'),
            Text(
                'Date:  ${DateFormat('EEEE, MMMM dd, yyyy   (hh:mm a)').format(emailModel.emailSendingTime.toDate())}'),
          ],
        ),
      ),
    );
  }

  Widget buildEmailBodySection(EmailModel emailModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        emailModel.emailBody != null && emailModel.emailBody!.isNotEmpty
            ? emailModel.emailBody!
            : '',
      ),
    );
  }

  Widget buildUserInfoListTile(EmailModel emailModel) {
    return ListTile(
      isThreeLine: true,
      leading: TextProfilePlaceholder(
        text: inboxMail
            ? nameToPlaceholder(
                emailModel.emailFrom.userFirstName,
                emailModel.emailFrom.userLastName,
              )
            : emailModel.emailTo[0].toUpperCase(),
        bgColor: Colors.greenAccent,
      ),
      title: Text(
        inboxMail
            ? '${emailModel.emailFrom.userFirstName} ${emailModel.emailFrom.userLastName}'
            : emailModel.emailTo.split('@')[0],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inboxMail ? 'to me ' : 'more info',
          ),
          InkWell(
            onTap: () {
              setState(() {
                showMore = !showMore;
              });
            },
            child: Icon(
              showMore ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
        ],
      ),
      trailing: Text(
        getFormattedDate(
          emailModel.emailSendingTime.toDate(),
        ),
      ),
    );
  }

  Widget buildSubjectSection(EmailModel emailModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        emailModel.emailSubject != null && emailModel.emailSubject!.isNotEmpty
            ? emailModel.emailSubject!
            : '(No Subject)',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
