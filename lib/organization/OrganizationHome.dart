import 'package:flutter/material.dart';
import 'package:sa3dni_app/organization/eventPage.dart';
import 'package:sa3dni_app/organization/organizationProfile.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/shared/constData.dart';
import 'package:sa3dni_app/wrapper.dart';

import '../patient/chat.dart';
import '../patient/settings.dart';

class OrganizationHome extends StatefulWidget {
  const OrganizationHome({Key? key}) : super(key: key);

  @override
  _OrganizationHomeState createState() => _OrganizationHomeState();
}

class _OrganizationHomeState extends State<OrganizationHome> with TickerProviderStateMixin {
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
        title: const Text('Home'),
        backgroundColor: ConstData().basicColor,
        actions: [
          FlatButton(
              onPressed:() {_authenticateService.singOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>  const Wrapper(),
              ));
              },
              child: const Icon(Icons.assignment_return_outlined,color: Colors.white,)

          ),
          FlatButton(
              onPressed:() {
              },
              child: const Icon(Icons.notifications,color: Colors.white,)

          )
        ],
      ),
      body: TabBarView(
          controller: _tabController,
          children:  [
            EventPage(),
            OrganizationProfile(),
            ChatPage(),
            Settings(),

          ]
      ),
      bottomNavigationBar:
      TabBar(

          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.event),
              text: 'Event',
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
