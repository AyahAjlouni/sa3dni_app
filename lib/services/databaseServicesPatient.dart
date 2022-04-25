import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/models/patient.dart';
import 'package:sa3dni_app/models/person.dart';

class DatabaseServicePatient{

  final patientCollection = FirebaseFirestore.instance.collection("patients");

  Future addPatient(Patient patient) async{
    return await patientCollection.add({
       'name':patient.name,
      'email':patient.email,
      "id" : patient.id,
      "category": patient.category.name
    });
  }






}