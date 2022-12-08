import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:ssmail/auth/auth_service.dart';
import 'package:ssmail/customwidget/text_profile_placeholder.dart';
import 'package:ssmail/pages/launcher_page.dart';
import 'package:ssmail/providers/user_provider.dart';
import 'package:ssmail/utils/constants.dart';
import 'package:ssmail/utils/helper_functions.dart';

class EmailDrawer extends StatefulWidget {
  final Function(String, String) emailBoxController;
  const EmailDrawer({Key? key, required this.emailBoxController})
      : super(key: key);

  @override
  State<EmailDrawer> createState() => _EmailDrawerState();
}

class _EmailDrawerState extends State<EmailDrawer> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            buildHeaderContainer(userProvider),
            const SizedBox(
              height: 20,
            ),
            buildDrawerButton(
              Icons.attach_email_rounded,
              EmailCategories.primary,
              () {
                widget.emailBoxController(
                    EmailBox.inbox, EmailCategories.primary);
                Navigator.pop(context);
              },
            ),
            buildDrawerButton(
              Icons.discount_rounded,
              EmailCategories.promotional,
              () {
                widget.emailBoxController(
                    EmailBox.inbox, EmailCategories.promotional);
                Navigator.pop(context);
              },
            ),
            buildDrawerButton(
              Icons.group_rounded,
              EmailCategories.social,
              () {
                widget.emailBoxController(
                    EmailBox.inbox, EmailCategories.social);
                Navigator.pop(context);
              },
            ),
            buildDrawerButton(
              Icons.forum_rounded,
              EmailCategories.forum,
              () {
                widget.emailBoxController(
                    EmailBox.inbox, EmailCategories.forum);
                Navigator.pop(context);
              },
            ),
            buildDrawerButton(
              Icons.send_sharp,
              'Sent',
              () {
                widget.emailBoxController(
                    EmailBox.sentBox, EmailCategories.noCategory);
                Navigator.pop(context);
              },
            ),
            buildSignOutButton(),
          ],
        ),
      ),
    );
  }

  Padding buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        onPressed: _signOut,
        child: Row(
          children: const [
            Icon(
              Icons.logout,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildDrawerButton(IconData icon, String text, Function() callback) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: TextButton(
        onPressed: callback,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Container buildHeaderContainer(UserProvider userProvider) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.green,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextProfilePlaceholder(
            text: nameToPlaceholder(
              userProvider.userModel!.userFirstName,
              userProvider.userModel!.userLastName,
            ),
            height: 100,
            width: 100,
            bgColor: Colors.amberAccent,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${userProvider.userModel!.userFirstName} ${userProvider.userModel!.userLastName}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            userProvider.userModel!.userEmail,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  //method to signing out from the app
  void _signOut() {
    EasyLoading.show(status: 'Signing out...');
    AuthService.signOut().then((value) {
      EasyLoading.dismiss();
      Navigator.pushReplacementNamed(context, LauncherPage.routeName);
    }).catchError((err) {
      EasyLoading.dismiss();
      showMsg(context, err.toString());
    });
  }
}
