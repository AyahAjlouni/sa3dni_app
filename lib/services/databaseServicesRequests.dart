import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServicesRequests{

  final requestCollection = FirebaseFirestore.instance.collection("requests");

  Future addRequest(String patientID , String organizationID ) async{
try{
  return await requestCollection.add({
    'patientId':patientID,
    'organizationID':organizationID,
    'status':'waiting'
  }).
    then((value) async {
   await FirebaseFirestore.instance.collection('requests')
        .doc(value.id)
        .update({
      'patientId': patientID,
      'organizationID': organizationID,
      'status' : 'waiting',
      'id':value.id
    });});

}catch(e){
  return null;
}

  }

  Future addId(String patientId, String organizationID,String status ,String id) async{
    return await FirebaseFirestore.instance.collection('requests')
         .doc(id)
        .update({
      'patientId': patientId,
      'organizationID': organizationID,
      'status' : status,
      'id':id
    }

    );
  }

  Future<String> getStatus(String patientID , String organizationID) async {
    await requestCollection
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if(doc["patientId"].toString().contains(patientID) &&
            doc['organizationID'].toString().contains(organizationID)){
         return doc['status'];
        }
      }
    });

    return 'nothing';
  }

  Future updateStatus(String id , String status,String patientId , String organizationID) async{
    return await FirebaseFirestore.instance.collection('requests')
        .doc(id)
        .update({
      'patientId': patientId,
      'organizationID': organizationID,
      'status' : status,
      'id':id
    }

    );
  }

  Future deleteRequest(String id ) async{
    return await FirebaseFirestore.instance.collection('requests')
        .doc(id)
        .delete();
  }
}