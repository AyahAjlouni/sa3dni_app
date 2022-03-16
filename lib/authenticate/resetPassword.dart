import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:flutter/material.dart';
import 'package:sa3dni_app/shared/constData.dart';
import '../shared/inputField.dart';
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final AuthenticateService _authService = AuthenticateService();
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9CDCA),
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: ConstData().basicColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: TextField(
              decoration: textInputField.copyWith(hintText: 'Email') ,
              onChanged: (val){
                setState(() {
                  email = val;
                });
              },
            ),
          ),
          RaisedButton(
            onPressed: () async {
              await  _authService.resetPassword(email);
              Navigator.of(context).pop();
            },
            child: const Text('Reset Password',
                style: TextStyle(color: Colors.white)),
            color: const Color(0xFF916F64),)
        ],
      ),
    );
  }
}
