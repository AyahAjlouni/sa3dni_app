import 'dart:async';

import 'category.dart';

class Person{
   late String name;
   late String  address;
   late Category category;
   late String phoneNumber;
   late String email;
   late String password;
   late String id;
   String type = '';
   StreamController<String> controller = StreamController<String>();
   Person({required this.id});

   Person.withSingInInfo({required this.email ,required this.password });

   Person.withPar({required this.name,
     required this.phoneNumber ,
     required this.address,
     required this.category,
   required this.password,
   required this.id});



   void setEmail(String email){
     this.email = email;
   }

   void setPassword(String password){
     this.password = password;
   }

   void setType(String type){
     this.type = type;
    Type;
   }


   Stream<String?> get Type{
     return controller.stream;
   }
}