import 'package:flutter/material.dart';
import 'package:sa3dni_app/homeWrapper.dart';
import 'package:sa3dni_app/patient/login.dart';
import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/services/databaseServicesPatient.dart';
import 'package:sa3dni_app/shared/constData.dart';

class SelectAnonOrNotSignIn extends StatelessWidget {
  Category category;
   SelectAnonOrNotSignIn({Key? key,required this.category}) : super(key: key);
   final AuthenticateService _authenticateService = AuthenticateService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstData().secColor,
      body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              RaisedButton(
                color: ConstData().basicColor,
                child:
              Text("Anon",style: TextStyle(color: Colors.white),),
              onPressed : () async {
              dynamic result = await _authenticateService.signInAnon();
              if(result != null) {
          //    await  DatabaseServicePatient().addAnonPatient(result, category);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>  HomeWrapper(),
                ));
              }
              }),
              SizedBox(width: 15,),
              RaisedButton(child: const Text("With Email And Password",
              style: TextStyle(color: Colors.white),),
                color: ConstData().basicColor,

              onPressed: () {/*  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>  SignIn(),
              ))*/}
              )
            ],
          ),
        )

    );
  }
}
