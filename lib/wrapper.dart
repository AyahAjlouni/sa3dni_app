import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/Home/homePage.dart';
import 'package:sa3dni_app/Home/questions.dart';
import 'package:sa3dni_app/Home/selectPage.dart';
import 'package:sa3dni_app/authenticate/login.dart';
import 'package:sa3dni_app/organization/orgaHome.dart';
import 'models/person.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person  = Provider?.of<Person?>(context);

    if(person == null){
     return const SignIn();
    }
    else {
      return SelectPage();
    }
  }
}
