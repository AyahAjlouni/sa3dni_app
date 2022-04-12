import 'package:flutter/material.dart';
import 'package:sa3dni_app/authenticate/verificationPage.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:sa3dni_app/shared/constData.dart';
import 'package:sa3dni_app/shared/inputField.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthenticateService _authService = AuthenticateService();
  String email = '';
  String password = '';
  bool load = false;

  final _keyVal = GlobalKey<FormState>();
  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,}$';
    RegExp regExp =  RegExp(pattern);
    return regExp.hasMatch(value);
  }
  @override
  Widget build(BuildContext context) {
         return Scaffold(
        backgroundColor: ConstData().secColor,
        appBar: AppBar(
          title: const Text('Sign up'),
          centerTitle: true,
          backgroundColor: ConstData().basicColor,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0,40.0,30.0,0.0),
              child: Form(
                key: _keyVal,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: textInputField.copyWith(hintText: 'Email'),
                      validator: (value) => value.toString().isNotEmpty ? null : 'Email Field can not be Empty ',
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
                      validator: (value) => validateStructure(value!) ? null :
                      'password should be contains\n1 upper case \n'
                          '1 lowercase \n'
                          '1 Numeric Number \n'
                          '1 Special Character ',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (value) => {
                        setState((){
                          password = value;
                        })
                      },
                    ),
                    const SizedBox(height: 15.0,),
                    RaisedButton(
                      onPressed: () async {
                        if (_keyVal.currentState!.validate()) {
                          dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                          if(result != null) {
                            if(!_authService.isVerificationEmail())
                            {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const VerifyByEmailPage()));
                              Fluttertoast.showToast(
                                  msg: "check your email to verify email",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }

                          }else{
                            Fluttertoast.showToast(
                                msg: "this Email is already used , try another email",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                        }
                      },
                      child: const Text('Sing up',
                        style: TextStyle(color: Colors.white),),
                      color: ConstData().basicColor,
                    ),
                    const SizedBox(height: 15.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Have an account?  ',
                          style: TextStyle(color: Colors.black),),
                        GestureDetector(
                          child: Text('Sign in',
                            style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),

              ),
            ),
          ],
        ),
      );
    }

  }

