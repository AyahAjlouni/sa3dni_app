import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/models/person.dart';
import 'package:sa3dni_app/shared/constData.dart';
import 'package:sa3dni_app/wrapper.dart';

import 'Home/selectCategory.dart';


class SelectPage extends StatelessWidget {
   SelectPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
         return Scaffold(
          backgroundColor: ConstData().secColor,
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Image(image: AssetImage('assets/patient.png')),
                        SizedBox(height: 10.0,),
                        Text("Patient",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      ]
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectCategory(isPatient: true)));

                  },
                ),
                const SizedBox(width: 60.0,),
                GestureDetector(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Image(image: AssetImage('assets/organization.png')),
                        SizedBox(height: 10.0,),
                        Text("Organization",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                      ]
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectCategory(isPatient: false)));
                  },
                ),

              ],
            ),
          )

          );


    }
  }

