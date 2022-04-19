import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Column(
           children: [
             CircleAvatar()
           ],
         )
    );
  }
}

