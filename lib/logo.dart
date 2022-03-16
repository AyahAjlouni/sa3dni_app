import 'package:flutter/material.dart';
import 'package:sa3dni_app/wrapper.dart';

void main() {
  runApp(const MaterialApp(
      home : LogoPage()
  ));
}

class LogoPage extends StatefulWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  void load()async{
    await Future.delayed(Duration(seconds: 3),
          () => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Wrapper(),))
          },);

  }
  @override
  void initState() {
    super.initState();
    load();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xF5F5F5FF),
      body:  Center(child: Image(
        image: AssetImage('assets/logo.png'),)),

    );
  }
}


