import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssmail/customwidget/email_drawer.dart';
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
  String appBarTitle = 'Inbox';

  @override
  void didChangeDependencies() {
    Provider.of<UserProvider>(context).getUserInfoByEmail();

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
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [],
      ),
      drawer: const EmailDrawer(),
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
}
