import 'package:flutter/material.dart';

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
        title: Text('View emails'),
      ),
    );
  }
}
