import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/models/patient.dart';

import '../shared/constData.dart';
class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PatientProfile> {

  Patient? patient;
  final currentUser = FirebaseAuth.instance.currentUser;
  int connectionCount = 0;
  @override
  void initState()  {
    super.initState();
   print(currentUser!.uid);
    FirebaseFirestore.instance
        .collection('patients')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["id"].toString().contains(currentUser!.uid)) {
          setState(() {
            patient = Patient(
                name: doc['name'],
                email: doc['email'],
                category: Category(name: doc['category']),
                id: doc['id']);
          });
        }
      }
    });

    FirebaseFirestore.instance
        .collection('requests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc["patientId"].toString().contains(currentUser!.uid)
            && doc['status'].toString().contains('accepted')) {
          setState(() {
            connectionCount++;
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if(patient != null) {
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
                  patient!.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                      color: Colors.pink),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('https://icons.iconarchive.com/icons/icons8/ios7/512/Users-User-Male-icon.png'),
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
                        Text(patient!.email),

                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                    const Text("Category",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 15,),
                    Text(patient!.category.name,style: const TextStyle(fontSize: 15),),
                  ],
                ),
                const SizedBox(width: 50,),
                GestureDetector(
                  child: Column(
                    children: [
                      const Text("Following",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15,),
                      Text(connectionCount.toString(),style: const TextStyle(fontSize: 15),),
                    ],
                  ),
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestList()));

                  },
                ),

              ],
            ),


          ],
        ),
      ),
    );
    }else{
    return  Container(
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

