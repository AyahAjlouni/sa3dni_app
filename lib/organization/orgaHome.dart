import 'package:flutter/material.dart';

class OrgaHome extends StatefulWidget {
  const OrgaHome({Key? key}) : super(key: key);

  @override
  _OrgaHomeState createState() => _OrgaHomeState();
}

class _OrgaHomeState extends State<OrgaHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}
