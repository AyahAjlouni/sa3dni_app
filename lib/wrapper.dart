import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/selectPage.dart';
import 'models/person.dart';
import 'package:sa3dni_app/homeWrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person  = Provider?.of<Person?>(context);

    if(person == null){
        return SelectPage();
    }
    else {
      return const HomeWrapper();
    }
  }
}

