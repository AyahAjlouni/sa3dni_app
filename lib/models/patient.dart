import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/models/person.dart';

class Patient extends Person{

  Patient.withPar({required String name,
    required String phoneNumber,
    required String email,
    required String address,
    required Category category}) : super(id: name);

}