import 'package:flutter/material.dart';
import 'package:sa3dni_app/shared/constData.dart';
import 'package:shimmer/shimmer.dart';
import '../models/category.dart';
import '../models/organization.dart';
import '../models/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Organization> organizations = <Organization>[];
  List<Request> requests = <Request>[];
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState()  {
    super.initState();


    FirebaseFirestore.instance
        .collection('requests')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc['patientId'].toString().contains(currentUser!.uid) &&
            doc['status'].toString().contains('accepted')) {
          setState(() {
            requests.add(Request(organizationId: doc['organizationID'],
                patientId: doc['patientId'],
                status: doc['status'],
                id: doc['id']));
          });
        }
      }});

    Future.delayed(const Duration(seconds: 3),(){
      if(requests.isNotEmpty){
        FirebaseFirestore.instance
            .collection('organization')
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            setState(() {
              organizations.add(
                // address , category , email , name , phoneNumber , rate
                  Organization(name: doc['name'],
                      phoneNumber: doc['phoneNumber'],
                      address: doc['address'],
                      category: Category(name: doc['category']),
                      email: doc['email'],
                      id: doc['id'],
                      image: doc['image']));
            });
          }
        });
      }

    });

  }




  @override
  Widget build(BuildContext context) {
    if(requests.isNotEmpty && organizations.isNotEmpty) {
      return Scaffold(
      body:   Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 0.0),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(getOrganization(requests[index].organizationId)!.image),
                          radius: 25,
                        ),
                        SizedBox(height: 10,),
                        Text(getOrganization(requests[index].organizationId)!.name)
                      ],
                    ),
                  );
                },
                // This next line does the trick.
                scrollDirection: Axis.horizontal,

              ),
            ),
          ),
          Divider(height: 20,color: ConstData().secColor,endIndent: 10,indent: 10,thickness: 2,),
          const Text('Chats')
        ],
      ),
    );
    }else{
     return Scaffold(
       backgroundColor: Colors.white,
       body:  Container(
         width: double.infinity,
         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
         child: Column(
           mainAxisSize: MainAxisSize.max,
           children: <Widget>[
             Expanded(
               child: Shimmer.fromColors(
                 baseColor: Colors.grey,
                 highlightColor: Colors.white,
                 child: ListView.builder(
                   itemBuilder: (_, __) => Padding(
                     padding: const EdgeInsets.only(bottom: 15.0),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Container(
                           width: 48.0,
                           height: 48.0,
                           color: Colors.white,
                         ),
                         const Padding(
                           padding: EdgeInsets.symmetric(horizontal: 8.0),
                         ),
                         Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               Container(
                                 width: double.infinity,
                                 height: 8.0,
                                 color: Colors.white,
                               ),
                               const Padding(
                                 padding: EdgeInsets.symmetric(vertical: 2.0),
                               ),
                               Container(
                                 width: double.infinity,
                                 height: 8.0,
                                 color: Colors.white,
                               ),
                               const Padding(
                                 padding: EdgeInsets.symmetric(vertical: 2.0),
                               ),
                               Container(
                                 width: 40.0,
                                 height: 8.0,
                                 color: Colors.white,
                               ),
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                   itemCount: 10,
                 ),
               ),
             ),

           ],
         ),
       ),

     );
    }
  }

  Organization? getOrganization(String id){

    for(var organization in organizations) {
      if(organization.id.contains(id)) {
        return organization;
      }
    }

    return null;
  }
}
