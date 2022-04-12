import 'package:flutter/material.dart';
import 'package:sa3dni_app/HomeWrapper.dart';
import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/models/organization.dart';
import 'package:sa3dni_app/services/authenticateService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa3dni_app/shared/constData.dart';
import '../models/person.dart';
import '../services/databaseServicePerson.dart';
import '../shared/inputField.dart';
import 'package:sa3dni_app/services/DatabaseServiceOrga.dart';

class RegisterOrganization extends StatefulWidget {
  Category category;
   RegisterOrganization({Key? key,required this.category}) : super(key: key);

  @override
  _RegisterOrganizationState createState() => _RegisterOrganizationState();
}

class _RegisterOrganizationState extends State<RegisterOrganization> {



  final _keyForm = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String phoneNumber = '', name = '' ,  address = '';
  final DatabaseServiceOrga _databaseServiceOrga =  DatabaseServiceOrga();

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[.!@#\$&*~]).{8,}$';
    RegExp regExp =  RegExp(pattern);
    return regExp.hasMatch(value);
  }
  @override
  void initState() {
    super.initState();
     }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Organization',style: TextStyle(color: Colors.white)),
        backgroundColor: ConstData().basicColor,
      ),
      backgroundColor: ConstData().secColor,
      body: Form(
        key: _keyForm,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
          child: Column(
            children: [
              TextFormField(
                decoration: textInputField.copyWith(hintText: 'Full Name'),
                validator: (value) => value.toString().isNotEmpty ? null : 'Name Field can not be Empty ',
                keyboardType: TextInputType.text,
                onChanged: (value) => {
                  setState((){
                    name = value;
                  })
                },
              ),
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputField.copyWith(hintText: 'Phone Number'),
                validator: (value) => value.toString().length > 10 ? null : 'Phone Number is not correct',
                keyboardType: TextInputType.phone,
                onChanged: (value) => {
                  setState((){
                    phoneNumber = value;
                  })
                },
              ),
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputField.copyWith(hintText: 'Address'),
                validator: (value) => value.toString().isNotEmpty ? null : 'Address can not be empty',
                keyboardType: TextInputType.streetAddress,
                onChanged: (value) => {
                  setState((){
                    address = value;
                  })
                },
              ),
              const SizedBox(height: 10.0,),
              RaisedButton(
                  onPressed: () async{
                    if(_keyForm.currentState!.validate()){
                      Person? person = await  AuthenticateService().registerWithEmailAndPassword(email, password);
                         if(person != null){
                           User? user = FirebaseAuth.instance.currentUser;

                           Organization organization = Organization(name: name, phoneNumber: phoneNumber,
                               address: address, category: widget.category,password: password,id:person.id);
                           await  DatabaseServicePerson().addUser(user!, "organization");

                           await  _databaseServiceOrga.addOrganization(organization);
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeWrapper()));

                         }

                    }
                  },
              child: const Text('Register'),
              )
            ],
          ),
        )
      ),
    );
  }
  }
