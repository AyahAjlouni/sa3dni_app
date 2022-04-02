import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/organization/orgaHome.dart';
import 'package:sa3dni_app/patient/patientHomePage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sa3dni_app/shared/constData.dart';

class HomeWrapper extends StatefulWidget {
   HomeWrapper({Key? key}) : super(key: key);

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  final persons = FirebaseFirestore.instance.collection("persons");

  final currentUser  = FirebaseAuth.instance.currentUser;

String role = "";

  @override
  void initState() {
     super.initState();

   FirebaseFirestore.instance
         .collection('persons')
         .get()
         .then((QuerySnapshot querySnapshot) {
       querySnapshot.docs.forEach((doc) {
         if(doc["id"].toString().contains(currentUser!.uid)){
           print(doc["role"]);
          setState(() {
            role =  doc['role'];
          });
         }
       });
     });

     print("Role"+role);
   }

  @override
  Widget build(BuildContext context) {
    print("Get role " + role);
    if(role.contains("patient")){

      return PatientHome();
    }

    else if(role.contains("organization"))
    {  print("organization");
    return OrgaHome();}
    return Center(
     child: SpinKitRotatingCircle(
       color: ConstData().basicColor,
       size: 50.0,
     ),
   );
  }
}
