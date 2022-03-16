import 'package:flutter/material.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/shared/constData.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthenticateService _authenticateService = AuthenticateService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstData().secColor,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: ConstData().basicColor,
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
