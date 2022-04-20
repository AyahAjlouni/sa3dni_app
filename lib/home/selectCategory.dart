
import 'package:flutter/material.dart';
import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/organization/organizationLogin.dart';
import 'package:sa3dni_app/patient/SelectAnonOrNotLogin.dart';
import 'package:sa3dni_app/shared/constData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class SelectCategory extends StatefulWidget {
  bool isPatient;
   SelectCategory({Key? key, required this.isPatient}) : super(key: key);

  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstData().basicColor,
        title: const Text('Select Category', style: TextStyle(color: Colors.white),),

      ),
      backgroundColor: ConstData().secColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('category').snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return GridView.builder(
                itemCount: snapshot.data?.docs.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemBuilder: (context,index){
                    DocumentSnapshot userData = snapshot.data!.docs[index];
                    return
                        GestureDetector(
                          child: Column(
                            children: [
                             CircleAvatar(
                               backgroundImage: NetworkImage(userData['image']),
                             backgroundColor: ConstData().secColor,
                             radius: 60.0),
                              const SizedBox(height: 4.0),
                              Text(userData['name'])
                      ]
                    ),
                          onTap: (){
                            Category category = Category(name: userData['name']);
                            if(widget.isPatient) {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder:(context) => SelectAnonOrNotSignIn()));
                            } else {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrganizationLogin(category: category,)));
                            }

                          },
                        );
                  });
            }
            else {
              return const LinearProgressIndicator();

            }}
        ),
      ) ,
    );
  }
}
