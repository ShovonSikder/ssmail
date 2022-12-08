import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:ssmail/auth/auth_service.dart';
import 'package:ssmail/models/user_model.dart';
import 'package:ssmail/pages/sign_in_page.dart';
import 'package:ssmail/providers/user_provider.dart';
import 'package:ssmail/utils/helper_functions.dart';

import 'launcher_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/sign_up';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String errMsg = '';

  bool obscure = true;

  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build sign up');
    return Scaffold(
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
                Icons.app_registration,
                color: Colors.green,
                size: 80,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Text(
                  'Sign Up to SS-MAIL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),

              //first name, last name input
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //first name
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First Name is required';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  //last name
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last Name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              //email input
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'New Email Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '@ssmail.com',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              //password input
              TextFormField(
                controller: _passwordController,
                obscureText: obscure,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                  labelText: 'New Password',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              //submit button
              ElevatedButton(
                onPressed: _signUpToApp,
                child: const Text(
                  'Sign Up',
                ),
              ),

              Row(
                children: [
                  const Text('You have an email?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, SignInPage.routeName);
                    },
                    child: const Text(
                      'Sign In',
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
    _firstNameController.dispose();
    _lastNameController.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //method for sign up
  void _signUpToApp() async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      EasyLoading.show(status: 'Signing Up...');

      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = '${_emailController.text.toLowerCase()}@ssmail.com';
      final password = _passwordController.text;

      try {
        if (await userProvider.doesUserExist(email)) {
          EasyLoading.dismiss();
          setState(() {
            errMsg =
                'This email already exist. Try a different username\nIf it\'s you please Sign In.';
          });
          return;
        } else {
          //create user by firebase auth
          await AuthService.signUp(email, password);

          //store user info in database
          final userModel = UserModel(
              userFirstName: firstName,
              userLastName: lastName,
              userEmail: email);
          await userProvider.addNewUser(userModel);
          EasyLoading.dismiss();

          if (mounted) {
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }
        }
      } catch (err) {
        EasyLoading.dismiss();
        setState(() {
          errMsg = err.toString();
        });
      }
    }
  }
}
