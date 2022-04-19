import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa3dni_app/models/event.dart';
import 'package:intl/intl.dart';
import 'package:sa3dni_app/shared/constData.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final currentUser = FirebaseAuth.instance.currentUser;
  List<OrganizationEvent> events = <OrganizationEvent>[];
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('events')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["organizationID"].toString().contains(currentUser!.uid)) {
          setState(() {
            String time = doc['time'].toString().substring(11, 15);
            events.add(OrganizationEvent(
                organizationID: currentUser!.uid,
                title: doc['title'],
                date: DateFormat.yMd().parse(doc['date']),
                time: TimeOfDay(
                    hour: int.parse(time.split(":")[0]),
                    minute: int.parse(time.split(":")[1])),
                location: doc['location'],
                description: doc['description']));
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (events.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
          backgroundColor: ConstData().basicColor,
        ),
        body: ListView.builder(
            itemCount: events.length,
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
                          events[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        const Divider(
                          height: 25,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Column(
                          children: [
                            Row(children: [
                              Icon(
                                Icons.date_range,
                                size: 20.0,
                                color: ConstData().basicColor,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                DateFormat.yMd()
                                    .format(events[index].date)
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            ]),
                            const SizedBox(height: 15,),
                            Row(children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: 20.0,
                                color: ConstData().basicColor,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                MaterialLocalizations.of(context)
                                    .formatTimeOfDay(events[index].time),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            ]),
                            const SizedBox(height: 15,),
                            Row(children: [
                              Icon(
                                Icons.location_on,
                                size: 20.0,
                                color: ConstData().basicColor,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Text(
                               events[index].location,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )
                            ]),
                          ],
                        ),
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
