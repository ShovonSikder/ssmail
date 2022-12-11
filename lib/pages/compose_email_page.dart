import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:ssmail/models/email_model.dart';
import 'package:ssmail/providers/user_provider.dart';
import 'package:ssmail/utils/helper_functions.dart';

class ComposeEmailPage extends StatefulWidget {
  static const String routeName = '/compose_email';

  const ComposeEmailPage({Key? key}) : super(key: key);

  @override
  State<ComposeEmailPage> createState() => _ComposeEmailPageState();
}

class _ComposeEmailPageState extends State<ComposeEmailPage> {
  late UserProvider userProvider;
  final _fromEmailController = TextEditingController();
  final _toEmailController = TextEditingController();
  final _emailSubjectController = TextEditingController();
  final _emailBodyController = TextEditingController();
  String body = '';

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    _fromEmailController.text = userProvider.userModel!.userEmail;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Compose',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
              onPressed: _sendEmail,
              icon: const Icon(
                Icons.send_sharp,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          //email From field
          TextField(
            readOnly: true,
            controller: _fromEmailController,
            decoration: InputDecoration(
              prefixIcon: buildPrefixInputFieldText('From'),
            ),
          ),

          //email To field
          TextField(
            controller: _toEmailController,
            decoration: InputDecoration(
              prefixIcon: buildPrefixInputFieldText('To'),
            ),
          ),

          //email subject field
          TextField(
            controller: _emailSubjectController,
            decoration: const InputDecoration(
              hintText: 'Subject',
            ),
          ),

          const SizedBox(
            height: 15,
          ),
          //email body field
          TextField(
            maxLines: 29,
            controller: _emailBodyController,
            decoration: const InputDecoration(
              hintText: 'Compose email',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Container buildPrefixInputFieldText(String text) {
    return Container(
      width: 60,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _sendEmail() async {
    FocusManager.instance.primaryFocus?.unfocus();

    EasyLoading.show(status: 'Sending...');
    final toEmail = _toEmailController.text;
    final subject = _emailSubjectController.text;
    final emailBody = _emailBodyController.text;

    if (toEmail.isEmpty) {
      EasyLoading.dismiss();
      showMsg(context, 'Enter the email address you want email to');
      return;
    } else if (await userProvider.doesUserExist(toEmail)) {
      final emailModel = EmailModel(
        emailFrom: userProvider.userModel!,
        emailTo: toEmail,
        emailSendingTime: Timestamp.fromDate(DateTime.now()),
        emailSubject: subject,
        emailBody: emailBody,
      );

      //assigning category to email
      emailModel.assignCategory();

      //send an email to given address
      userProvider.sendEmailTo(toEmail, emailModel).then((value) {
        EasyLoading.dismiss();
        Navigator.pop(context);
        showMsg(context, 'Email send successfully');
      }).catchError((err) {
        EasyLoading.dismiss();
        showMsg(context, 'Can\'t send this email. ${err.toString()}');
      });
    } else {
      //in case email address not found
      EasyLoading.dismiss();
      showMsg(context,
          'Can\'t send this email. The email $toEmail is not registered in our network. Try a valid ssmail address');
    }
  }

  @override
  void dispose() {
    _fromEmailController.dispose();
    _toEmailController.dispose();
    _emailSubjectController.dispose();
    _emailBodyController.dispose();
    super.dispose();
  }
}
