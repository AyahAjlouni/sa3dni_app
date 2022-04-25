import 'package:flutter/material.dart';

class OrganizationChat extends StatefulWidget {
  const OrganizationChat({Key? key}) : super(key: key);

  @override
  _OrganizationChatState createState() => _OrganizationChatState();
}

class _OrganizationChatState extends State<OrganizationChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            // This next line does the trick.
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 160.0,
                color: Colors.red,
              ),
              Container(
                width: 160.0,
                color: Colors.blue,
              ),
              Container(
                width: 160.0,
                color: Colors.green,
              ),
              Container(
                width: 160.0,
                color: Colors.yellow,
              ),
              Container(
                width: 160.0,
                color: Colors.orange,
              ),
            ],
          ),

        ],
      )
    );
  }
}
