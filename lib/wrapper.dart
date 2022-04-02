import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/authenticate/login.dart';
import 'package:sa3dni_app/organization/orgaHome.dart';
import 'package:sa3dni_app/selectPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home/selectCategory.dart';
import 'organization/registerOrga.dart';
import 'patient/patientHomePage.dart';
import 'models/person.dart';
import 'package:sa3dni_app/HomeWrapper.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person  = Provider?.of<Person?>(context);

    if(person == null){
        return SelectPage();
    }
    else
      return HomeWrapper();
  }
}

