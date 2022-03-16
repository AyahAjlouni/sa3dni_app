import 'package:flutter/material.dart';
import 'package:sa3dni_app/authenticate/login.dart';
import 'package:sa3dni_app/logo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/wrapper.dart';

import 'models/person.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Person?>.value(
      catchError:(context, error) => null ,
      value: AuthenticateService().user,
      initialData: null,
      child: const MaterialApp(
        home: LogoPage(),
      ),
    );
  }
}



