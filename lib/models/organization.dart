import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/models/person.dart';

class Organization extends Person{

  List<int> listOfRate =  [];
  late String image;
  Organization.withNoParameter():super.withNoParameter();
  Organization({required String name,
    required String phoneNumber,
    required String address,
    required Category category,
     required String email,
      required String id,
     required this.image}) :
        super.withPar(name: name, phoneNumber: phoneNumber, address: address,
          category: category,email: email,id: id);

     void setRate(int rate){
       listOfRate.add(rate);
     }

     List<int> getAllRate(){
       return listOfRate;
     }

     double getRate(){

       int sumOfRate = 0;
       for(int rate in listOfRate){
         sumOfRate += rate;
       }

       if(listOfRate.isEmpty) {
         return 0;
       }
       return sumOfRate / (listOfRate.length * 1.0);
     }
}