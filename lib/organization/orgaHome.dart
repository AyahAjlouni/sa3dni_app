import 'package:flutter/material.dart';
import 'package:sa3dni_app/services/authenticateService.dart';

class OrgaHome extends StatefulWidget {
  const OrgaHome({Key? key}) : super(key: key);

  @override
  _OrgaHomeState createState() => _OrgaHomeState();
}

class _OrgaHomeState extends State<OrgaHome> {
  AuthenticateService _authenticateService = AuthenticateService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          FlatButton(
              onPressed:() => _authenticateService.singOut(),
              child: const Text('sign out',
                style: TextStyle(color: Colors.white),)

          )
        ],
      ),
    );
  }
}
