import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssmail/customwidget/email_drawer.dart';
import 'package:ssmail/customwidget/email_list_tile.dart';
import 'package:ssmail/pages/compose_email_page.dart';
import 'package:ssmail/providers/user_provider.dart';
import 'package:ssmail/utils/constants.dart';

class ViewEmailPage extends StatefulWidget {
  static const String routeName = '/view_email';

  const ViewEmailPage({Key? key}) : super(key: key);

  @override
  State<ViewEmailPage> createState() => _ViewEmailPageState();
}

class _ViewEmailPageState extends State<ViewEmailPage> {
  String showingCategory = EmailCategories.primary;
  String appBarTitle = EmailBox.inbox;

  // late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    // userProvider = Provider.of<UserProvider>(context, listen: false);

    _fetchAllEmails();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appBarTitle,
            ),
            if (showingCategory != EmailCategories.noCategory)
              Text(
                showingCategory,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          bool showEmptyMsg;
          appBarTitle == EmailBox.inbox
              ? showEmptyMsg = provider.inbox.isEmpty
              : showEmptyMsg = provider.sentBox.isEmpty;

          final List<Widget> emailsToDisplay = _getEmailListToDisplay(provider);

          return showEmptyMsg
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        appBarTitle == EmailBox.sentBox
                            ? Icons.outbox_outlined
                            : Icons.move_to_inbox_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      Text(
                        appBarTitle == EmailBox.sentBox
                            ? 'This sent box is empty'
                            : 'This inbox is empty',
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 150,
                        child: LinearProgressIndicator(),
                      ),
                    ],
                  ),
                )
              : emailsToDisplay.isNotEmpty
                  ? ListView(
                      padding: const EdgeInsets.all(8),
                      children: emailsToDisplay,
                    )
                  //in case email list empty after filtering by category
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_copy_rounded,
                            size: 70,
                            color: Colors.grey,
                          ),
                          Text(
                            'No emails in $showingCategory category',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    );
        },
      ),
      drawer: EmailDrawer(emailBoxController: (emailBox, category) {
        //call back for filtering  email box and categories emails
        setState(() {
          appBarTitle = emailBox;
          showingCategory = category;
        });
      }),
      floatingActionButton: buildEmailComposeButton(),
    );
  }

  //email compose button
  Container buildEmailComposeButton() {
    return Container(
      height: 50,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ComposeEmailPage.routeName);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                'Compose',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getEmailListToDisplay(UserProvider userProvider) {
    if (appBarTitle == EmailBox.inbox) {
      return userProvider.inbox
          .where((email) => email.category == showingCategory) //filtering
          .map(
            (email) => EmailListTile(email: email),
          )
          .toList();
    } else if (appBarTitle == EmailBox.sentBox) {
      return userProvider.sentBox
          .map(
            (email) => EmailListTile(
              email: email,
              emailBox: EmailBox.sentBox,
            ),
          )
          .toList();
    }
  }

  void _fetchAllEmails() async {
    //fetch data from email
    await Provider.of<UserProvider>(context, listen: false)
        .getUserInfoByEmail();
    await Provider.of<UserProvider>(context, listen: false)
        .getAllInboxMailsByEmail();
    await Provider.of<UserProvider>(context, listen: false)
        .getAllSentBoxMailsByEmail();
  }
}
