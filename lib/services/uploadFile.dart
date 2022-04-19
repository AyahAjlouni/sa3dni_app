import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFile {

  File? file;
  UploadTask? task;
  String image = '';

  String getUriFile(){
    return image;
  }
  Future selectFile() async {

      final result = await FilePicker.platform.pickFiles(allowMultiple: false );
      if (result == null) return;
      final path = result.files.single.path;

      file = File(path!);


  }

  Future uploadFile() async{
    if(file == null) return;

    final fileName = basename(file!.path);
    final des = 'images/$fileName';

    task = uploadTask(des);

    if(task == null) return;

    final snapShot = await task!.whenComplete(() => {});
    final urlFile =  await snapShot.ref.getDownloadURL();
    image = urlFile;
    print('url File' + urlFile);
  }

  UploadTask? uploadTask (String des){
    final ref = FirebaseStorage.instance.ref(des);

    return ref.putFile(file!);
  }
}