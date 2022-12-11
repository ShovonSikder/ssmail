import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:ssmail/pages/compose_email_page.dart';
import 'package:ssmail/pages/email_read_page.dart';
import 'package:ssmail/pages/launcher_page.dart';
import 'package:ssmail/pages/sign_in_page.dart';
import 'package:ssmail/pages/sign_up_page.dart';
import 'package:ssmail/pages/view_email_page.dart';
import 'package:ssmail/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      builder: EasyLoading.init(),
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        ViewEmailPage.routeName: (context) => const ViewEmailPage(),
        SignInPage.routeName: (context) => const SignInPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        ComposeEmailPage.routeName: (context) => const ComposeEmailPage(),
        EmailReadPage.routeName: (context) => const EmailReadPage(),
      },
    );
  }
}
