import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/shared/constData.dart';
class OrganizationList extends StatefulWidget {
  const OrganizationList({Key? key}) : super(key: key);

  @override
  State<OrganizationList> createState() => _OrganizationListState();
}

class _OrganizationListState extends State<OrganizationList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('organization').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // address , category , email , name , phoneNumber , rate
              return  ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot userData =
                    snapshot.data!.docs[index];
                    return
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                            child: ListTile(
                              title: Row(
                                children:  [
                                  const Text('Name : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        fontFamily: 'DancingScript'
                                    ),),
                                  Text(userData['name'],
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'DancingScript'
                                    ),),
                                ],
                              ),
                              subtitle:Column(
                                children: [
                                  Row(
                                    children:  [
                                      const Text('Address : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            fontFamily: 'DancingScript'
                                        ),),
                                      Text(userData['address'],
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'DancingScript'
                                        ),),
                                    ],
                                  ),
                                  Row(
                                    children:  [
                                      const Text('Rate : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                            fontFamily: 'DancingScript'
                                        ),),
                                      Text(userData['rate'],
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: 'DancingScript'
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(backgroundImage: NetworkImage(userData['image']),
                                backgroundColor: Colors.white,
                                radius: 30.0,
                            )  ,

                          )

                          ),
                          Divider(color: ConstData().basicColor,height: 20.0,endIndent: 30.0,indent: 30.0,)
                        ],

                    );
                  }
              );
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
