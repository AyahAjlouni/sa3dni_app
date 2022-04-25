import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/models/person.dart';

class Patient extends Person{

  Patient({required String name ,
    required String email,
    required Category category,
  required String id}) : super.withPatientInfo(name: name, email: email, category: category, id: id);

}