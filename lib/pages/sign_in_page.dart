//this page use to take user input for sign in to the app

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ssmail/pages/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = '/sign_in';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('SignIn'),
      // ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.lock_person_outlined,
                color: Colors.green,
                size: 80,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Text(
                  'Sign In to SS-MAIL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),

              //email input
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                },
              ),

              const SizedBox(
                height: 15,
              ),

              //password input
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                },
              ),

              const SizedBox(
                height: 20,
              ),

              //submit button
              ElevatedButton(
                onPressed: _signInToApp,
                child: const Text(
                  'Sign In',
                ),
              ),

              Row(
                children: [
                  const Text('Don\'t have an email yet?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpPage.routeName);
                    },
                    child: const Text(
                      'Sign Up',
                    ),
                  ),
                ],
              ),

              //error message box
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  errMsg,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInToApp() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      // EasyLoading.show();
    }
  }
}
