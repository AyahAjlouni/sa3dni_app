import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/models/organization.dart';


class DatabaseServiceOrga{

  final collectionOrga = FirebaseFirestore.instance.collection('organization');

  Future addOrganization(Organization organization ) async{
    collectionOrga.add({
      'name': organization.name,
      'address':organization.address,
      'category':organization.category.name,
      'phoneNumber':organization.email,
      'rate':organization.getRate().toString()
    });
  }


}