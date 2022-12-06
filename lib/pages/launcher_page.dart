import 'package:flutter/material.dart';
import 'package:ssmail/auth/auth_service.dart';
import 'package:ssmail/pages/sign_in_page.dart';
import 'package:ssmail/pages/view_email_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        if (AuthService.currentUser != null) {
          Navigator.pushReplacementNamed(context, ViewEmailPage.routeName);
        } else {
          Navigator.pushReplacementNamed(context, SignInPage.routeName);
        }
      },
    );
    return const Scaffold(
      body: Center(
        //show a progress indication while routing between pages
        child: CircularProgressIndicator(),
      ),
    );
  }
}
