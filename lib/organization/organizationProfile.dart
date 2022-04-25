import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sa3dni_app/models/event.dart';
import 'package:sa3dni_app/models/organization.dart';
import 'package:sa3dni_app/models/request.dart';
import 'package:sa3dni_app/organization/eventList.dart';
import 'package:sa3dni_app/organization/requestList.dart';
import 'package:sa3dni_app/services/DatabaseServiceOrga.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa3dni_app/shared/constData.dart';

import '../models/category.dart';

class OrganizationProfile extends StatefulWidget {
  OrganizationProfile({Key? key}) : super(key: key);

  @override
  State<OrganizationProfile> createState() => _OrganizationProfileState();
}

class _OrganizationProfileState extends State<OrganizationProfile> {
  Organization? _organization;

  double rate = 0.0;
  String image = '';
  final currentUser = FirebaseAuth.instance.currentUser;
  int eventCount = 0;
  int requestCount = 0;
  List<Request> requests = <Request>[];
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('organization')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['id'].toString().contains(currentUser!.uid)) {
          print(doc["image"]);
          setState(() {
            image = doc['image'];
          });
        }
      }
    });
    FirebaseFirestore.instance
        .collection('organization')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["id"].toString().contains(currentUser!.uid)) {
          setState(() {
            _organization = Organization(
                name: doc['name'],
                phoneNumber: doc['phoneNumber'],
                address: doc['address'],
                category: Category(name: doc['category']),
                email: doc['email'],
                id: doc['id'],
            image: doc['image']);
            rate = double.parse(doc['rate']);
          });
        }
      }
    });

    FirebaseFirestore.instance
        .collection('requests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["organizationID"].toString().contains(currentUser!.uid)
            && doc['status'].toString().contains('waiting')) {
          setState(() {
           requestCount++;
          });
        }
      }
    });

    FirebaseFirestore.instance
        .collection('events')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["organizationID"].toString().contains(currentUser!.uid)) {
          setState(() {
            eventCount++;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if (image.isNotEmpty && _organization != null) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Hi, ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  Text(
                    _organization!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                        color: Colors.pink),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 60,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                           Icon(
                            Icons.email,
                            color: Colors.red[800],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_organization!.email),

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                           Icon(
                            Icons.phone,
                            color: Colors.green[800],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_organization!.phoneNumber),

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                           Icon(
                            Icons.location_on,
                            color: Colors.blue[900],
                          ),
                          SizedBox(width: 10,),
                          Text(_organization!.address)
                        ],
                      ),

                    ],
                  ),
                ],
              ),
              Divider(height: 50,color: ConstData().basicColor,indent: 20,endIndent: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("Rate",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15,),
                      Text(rate.toString(),style: const TextStyle(fontSize: 15),),
                    ],
                  ),
                  const SizedBox(width: 50,),
                  Column(
                    children: [
                      const Text("Category",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15,),
                      Text(_organization!.category.name,style: const TextStyle(fontSize: 15),),
                    ],
                  ),
                  const SizedBox(width: 50,),
                  GestureDetector(
                    child: Column(
                      children: [
                        const Text("Events",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 15,),
                        Text(eventCount.toString(),style: const TextStyle(fontSize: 15),),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EventList()));

                    },
                  ),
                ],
              ),
              SizedBox(height: 20,),
              GestureDetector(
                child: Column(
                  children: [
                    const Text("Request",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15,),
                    Text(requestCount.toString(),style: const TextStyle(fontSize: 15),),
                  ],
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestList()));

                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 30),
        child: Card(
          child: ListTile(
            title: Column(
              children: <Widget>[
                Icon(
                  Icons.tag_faces,
                  color: Theme.of(context).primaryColor,
                  size: 35.0,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  "No Record Found",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
