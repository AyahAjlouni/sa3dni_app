import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3dni_app/models/category.dart';
import 'package:sa3dni_app/models/organization.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseServiceOrga{

  final collectionOrga = FirebaseFirestore.instance.collection('organization');
  final currentUser  = FirebaseAuth.instance.currentUser;
  Future addOrganization(Organization organization,String id,String image ) async{
    try{
      return await collectionOrga.add({
      'name': organization.name,
      'address':organization.address,
      'category':organization.category.name,
      'phoneNumber':organization.phoneNumber,
      'rate':organization.getRate().toString(),
        'id':organization.id,
        'image':image,
        'email':organization.email
    });
    }
    catch(e){
      return null;

    }
  }

   Organization getCurrentOrganization(){
     Organization or;
     FirebaseFirestore.instance
         .collection('organization')
         .get()
         .then((QuerySnapshot querySnapshot) {
       for (var doc in querySnapshot.docs) {
         if(doc["id"].toString().contains(currentUser!.uid)){
         or = Organization(name: doc['name'],
             phoneNumber: doc['phoneNumber'],
             address: doc['address'],
             category: Category(name:doc['category'] ),
             email: doc['email'],
             id: doc['id'],
         image: doc['image']);
          }
       }
     });
return Organization.withNoParameter();   }

   String getImageOfOrganization() {
     String image = 'https://icons.iconarchive.com/icons/icons8/ios7/512/Users-User-Male-icon.png';
     FirebaseFirestore.instance
         .collection('organization')
         .get()
         .then((QuerySnapshot querySnapshot) {
       for (var doc in querySnapshot.docs) {
         if(doc["id"].toString().contains(currentUser!.uid)){
           print("Hello");
           return doc['image'];
         }
       }
     });
print("hi");
     return image;
   }
}