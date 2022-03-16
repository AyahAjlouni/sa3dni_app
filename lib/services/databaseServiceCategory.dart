import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceCategory{

  final CollectionReference categoryCollection = FirebaseFirestore.instance
      .collection('category');

  Future addCategory(String name , String image) async{
    return await categoryCollection.add({
      'name' : name,
      'image' : image
    });
  }

  Stream<QuerySnapshot> getAllCategroy(){
    return categoryCollection.snapshots();
  }
}