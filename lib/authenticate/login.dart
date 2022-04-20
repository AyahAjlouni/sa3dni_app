import 'package:sa3dni_app/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:sa3dni_app/authenticate/resetPassword.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/shared/inputField.dart';
import 'package:sa3dni_app/shared/constData.dart';
import 'package:sa3dni_app/wrapper.dart';
class SignIn extends StatefulWidget {

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthenticateService _authService = AuthenticateService();
  final _keyVal = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ConstData().secColor,
        appBar: AppBar(
          title: const Text('Sign in'),
          centerTitle: true,
          backgroundColor: ConstData().basicColor,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0,70.0,30.0,0.0),
              child: Form(
                key: _keyVal,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textInputField.copyWith(hintText: 'Email'),
                      validator: (value) => value.toString().isNotEmpty ? null : 'Enter your valid Email ',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => {
                        setState((){
                          email = value;
                        })
                      },
                    ),
                    const SizedBox(height: 15.0,),
                    TextFormField(
                      decoration: textInputField.copyWith(hintText: 'Password'),
                      keyboardType: TextInputType.text,
                      validator: (value) => value.toString().length > 8 ? null : 'password should be more than 6 char ',
                      obscureText: true,
                      onChanged: (value) => {
                        setState((){
                          password = value;
                        })
                      },
                    ),
                    const SizedBox(height: 15.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Text('Forgot Password?',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ResetPasswordPage(),
                            ));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0,),
                    RaisedButton(
                      onPressed: () async {
                        if (_keyVal.currentState!.validate()) {
                          setState(() {
                            load = true;
                          });
                          dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                          if(result != null) {
                            setState(() {
                              load = false;
                            });
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const Wrapper(),
                            ));
                          }

                        }
                      },
                      child: const Text('Sing in',
                          style: TextStyle(color: Colors.white)),
                      color: ConstData().basicColor,
                    ),

                    const SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No account ? ',
                          style: TextStyle(color: Colors.black),),
                        GestureDetector(
                          child: Text('Sign Up',
                            style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Register(),
                            ));
                          },
                        ),
                      ],
                    )
                  ],
                ),

              ),
            ),
          ],
        )
    );
  }
}

