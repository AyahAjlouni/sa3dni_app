import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/models/request.dart';
import 'package:sa3dni_app/services/databaseServicesRequests.dart';

import '../shared/constData.dart';
class RequestList extends StatefulWidget {
  const RequestList({Key? key}) : super(key: key);

  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  final currentUser = FirebaseAuth.instance.currentUser;
  List<Request> requests = <Request>[];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('requests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["organizationID"].toString().contains(currentUser!.uid)
            && doc['status'].toString().contains('waiting')) {
          setState(() {
            requests.add(Request(organizationId: currentUser!.uid,
                patientId:doc['patientId'],
                status: doc['status'],
                id : doc['id']));
          });
        }
      }
    });

  }
  @override
  Widget build(BuildContext context) {

    if (requests.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          backgroundColor: ConstData().basicColor,
        ),
        body: ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border:
                      Border.all(color: ConstData().basicColor, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                         requests[index].status,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                           FlatButton.icon(
                               onPressed: () async{
                              await   DatabaseServicesRequests().
                                 updateStatus(requests[index].id, 'accepted',
                                     requests[index].patientId,
                                     requests[index].organizationId);
                              setState(() {
                                requests = [];
                                FirebaseFirestore.instance
                                    .collection('requests')
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  for (var doc in querySnapshot.docs) {
                                    if (doc["organizationID"].toString().contains(currentUser!.uid)
                                        && doc['status'].toString().contains('waiting')) {
                                      setState(() {
                                        requests.add(Request(organizationId: currentUser!.uid,
                                            patientId:doc['patientId'],
                                            status: doc['status'],
                                            id : doc['id']));
                                      });
                                    }
                                  }
                                });
                              });
                               },
                               icon: const Icon(Icons.add),
                               label: const Text('Accept')),
                            SizedBox(width: 20,),
                            FlatButton.icon(
                                onPressed: () async{
                                  await   DatabaseServicesRequests().
                                  updateStatus(requests[index].id, 'rejected',
                                      requests[index].patientId,
                                      requests[index].organizationId);
                                  setState(() {
                                    requests = [];
                                    FirebaseFirestore.instance
                                        .collection('requests')
                                        .get()
                                        .then((QuerySnapshot querySnapshot) {
                                      for (var doc in querySnapshot.docs) {
                                        if (doc["organizationID"].toString().contains(currentUser!.uid)
                                            && doc['status'].toString().contains('waiting')) {
                                          setState(() {
                                            requests.add(Request(organizationId: currentUser!.uid,
                                                patientId:doc['patientId'],
                                                status: doc['status'],
                                                id : doc['id']));
                                          });
                                        }
                                      }
                                    });
                                  });
                                },
                                icon: const Icon(Icons.cancel),
                                label: const Text('Reject'))
                          ],
                        )

                          ],
                        ),

                    ),

                ),
              );
            }),
      );
    } else {}
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

