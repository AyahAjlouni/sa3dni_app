import 'package:flutter/material.dart';
import 'package:sa3dni_app/organization/organizationList.dart';
import 'package:sa3dni_app/patient/chat.dart';
import 'package:sa3dni_app/patient/patientProfile.dart';
import 'package:sa3dni_app/patient/settings.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/shared/constData.dart';

import '../wrapper.dart';
class PatientHome extends StatefulWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> with TickerProviderStateMixin {
  final AuthenticateService _authenticateService = AuthenticateService();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstData().basicColor,
      appBar: AppBar(
        title: const Text('Patient Home'),
        backgroundColor: ConstData().basicColor,
        actions: [
          FlatButton(
              onPressed:() {_authenticateService.singOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>  const Wrapper(),
              ));
                        },
              child: const Text('sign out',
              style: TextStyle(color: Colors.white),)

          )
        ],
      ),
      body: TabBarView(
          controller: _tabController,
          children: const [
          OrganizationList(),
          PatientProfile(),
          ChatPage(),
          Settings(),

          ]
      ),
       bottomNavigationBar:
       TabBar(

           controller: _tabController,
           tabs: const [
             Tab(
               icon: Icon(Icons.home),
               text: 'Home',
             ),
             Tab(
               icon: Icon(Icons.person),
               text: 'My Profile',
             ),
             Tab(
               icon: Icon(Icons.chat_bubble),
               text: 'Chat',
             ),
             Tab(
               icon: Icon(Icons.settings),
               text: 'Setting',
             ),
           ]

       ),

    );
  }
}
