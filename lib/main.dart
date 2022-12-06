import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssmail/pages/launcher_page.dart';
import 'package:ssmail/pages/sign_in_page.dart';
import 'package:ssmail/pages/sign_up_page.dart';
import 'package:ssmail/pages/view_email_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        ViewEmailPage.routeName: (context) => const ViewEmailPage(),
        SignInPage.routeName: (context) => const SignInPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
      },
    );
  }
}
