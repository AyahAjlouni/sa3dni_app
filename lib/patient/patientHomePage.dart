import 'package:flutter/material.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/shared/constData.dart';

import '../wrapper.dart';
class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  final AuthenticateService _authenticateService = AuthenticateService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstData().secColor,
      appBar: AppBar(
        title: const Text('Patient Home'),
        backgroundColor: ConstData().basicColor,
        actions: [
          FlatButton(
              onPressed:() {_authenticateService.singOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>  Wrapper(),
              ));
                        },
              child: const Text('sign out',
              style: TextStyle(color: Colors.white),)

          )
        ],
      ),

    );
  }
}
