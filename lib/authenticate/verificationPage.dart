import 'dart:async';
import 'package:sa3dni_app/selectPage.dart';
import 'package:sa3dni_app/authenticate/login.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:provider/provider.dart';
import 'package:sa3dni_app/models/person.dart';
import 'package:sa3dni_app/patient/patientHomePage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:sa3dni_app/shared/constData.dart';

class VerifyByEmailPage extends StatefulWidget {
  const VerifyByEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyByEmailPageState createState() => _VerifyByEmailPageState();
}

class _VerifyByEmailPageState extends State<VerifyByEmailPage> {
  bool isVerifyEmail = false;
  final AuthenticateService _authService = AuthenticateService();
  Timer? timer;
  @override
  void initState() {
    super.initState();

    isVerifyEmail =  _authService.isVerificationEmail();

    if(!isVerifyEmail) {
      _authService.sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3),
              (timer) {
            checkEmailVerification();
          });
    }
  }

  Future checkEmailVerification() async{
    await _authService.reloadStatusOfUser();

    setState(() {
      isVerifyEmail = _authService.isVerificationEmail();
    });

    if(isVerifyEmail){
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final person = Provider?.of<Person?>(context);
    if(person == null)
      return SignIn();
    else if(isVerifyEmail) {
      return SelectPage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
          backgroundColor: ConstData().basicColor,
        ),
        backgroundColor: ConstData().secColor,
        body:  Center(
          child: SpinKitRotatingCircle(
            color: ConstData().basicColor,
            size: 50.0,
          ),
        ),

      );
    }

  }
}
