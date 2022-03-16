import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/Home/homePage.dart';
import 'package:sa3dni_app/Home/questions.dart';
import 'package:sa3dni_app/Home/selectPage.dart';
import 'package:sa3dni_app/authenticate/login.dart';
import 'package:sa3dni_app/organization/orgaHome.dart';
import 'models/person.dart';

class Wrapper2 extends StatelessWidget {
  const Wrapper2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type  = Provider?.of<String?>(context);

    if(type?.compareTo('patient') == 0){
      return  QuestionTemp();
    }
    else {
      return OrgaHome();
    }
  }
}
