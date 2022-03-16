import 'package:flutter/material.dart';
import 'package:sa3dni_app/Home/selectCategory.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/models/person.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/shared/constData.dart';

import '../wrapper2.dart';

class SelectPage extends StatelessWidget {
   SelectPage({Key? key}) : super(key: key);
  final AuthenticateService _authenticateService = AuthenticateService();
  @override
  Widget build(BuildContext context) {
    final person  = Provider?.of<Person?>(context);
    if(person!.type.isEmpty){
      return Scaffold(
          appBar: AppBar(
            backgroundColor: ConstData().basicColor,
            actions: [
              FlatButton(
                  onPressed: () {
                    _authenticateService.singOut();
                  },
                  child: Text('Sing Out',
                    style: TextStyle(color: Colors.white),))
            ],
          ),
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
                    person?.setType('patient');
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
                    person?.setType('orga');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCategory(isPatient: false,)));
                  },
                ),

              ],
            ),
          ));
    }else {
      return StreamProvider<String?>.value(
      initialData: null,
      value: person?.Type,
      catchError: (context,error) => null,
      child:  Wrapper2()
    );
    }
  }
}
