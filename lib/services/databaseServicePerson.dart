import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServicePerson{

  final db = FirebaseFirestore.instance.collection("persons");

  Future addUser(User user,String role) async{
     db.add({
       "id" : user.uid,
       "role": role
     });
  }






}