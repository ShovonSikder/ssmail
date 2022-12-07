import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ssmail/auth/auth_service.dart';
import 'package:ssmail/pages/launcher_page.dart';
import 'package:ssmail/utils/helper_functions.dart';

class ViewEmailPage extends StatefulWidget {
  static const String routeName = '/view_email';
  const ViewEmailPage({Key? key}) : super(key: key);

  @override
  State<ViewEmailPage> createState() => _ViewEmailPageState();
}

class _ViewEmailPageState extends State<ViewEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View emails'),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
    );
  }

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
