import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/models/event.dart';
import 'package:intl/intl.dart';


class DatabaseServiceEvent{

  final collectionEvent = FirebaseFirestore.instance.collection('events');

  Future addEvent(OrganizationEvent event ) async{
    try{
      return await  collectionEvent.add({
        'organizationID':event.organizationID,
        'title' : event.title,
        'date' :   DateFormat.yMd().format(event.date).toString(),
        'time' : event.time.toString(),
        'location':event.location,
        'description':event.description
      });
    }catch(e){
      return null;
    }

  }


}