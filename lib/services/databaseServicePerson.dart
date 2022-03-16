import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/models/person.dart';


class DatabaseServicePerosn{

  final collectionPerson = FirebaseFirestore.instance.collection('persons');

  Future addPerson(Person person ) async{
    collectionPerson.add({
     'id':person.id,
     'email':person.email,
     'password':person.password
    });
  }





}