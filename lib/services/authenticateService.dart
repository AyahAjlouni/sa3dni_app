import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa3dni_app/models/person.dart';
import 'package:sa3dni_app/services/databaseServicePerson.dart';
class AuthenticateService{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  /// convert user to Person
  Person? getUserFromFirebase(User? user){
    return user != null ? Person(id: user.uid) : null;
  }

   /// get status of current user
  Stream<Person?> get user{
    return _firebaseAuth.authStateChanges().map((event) => getUserFromFirebase(event!));
  }


  Future registerWithEmailAndPassword(String email , String password) async{
    try{
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      Person? person = getUserFromFirebase(user);
      person?.setEmail(email);
      person?.setPassword(password);
      return person;
    }catch(e){
      return null;
    }
  }


 ///  Sign in With Email and Password
  Future signInWithEmailAndPassword(String email , String password) async{
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return getUserFromFirebase(user);
    }catch(e){
      return null;
    }
  }

  /// Reset Password
  Future resetPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// is Verification by Email
  bool isVerificationEmail() {
    return _firebaseAuth.currentUser!.emailVerified;
  }

    /// send Verification Email
  Future sendVerificationEmail() async{
    return await _firebaseAuth.currentUser!.sendEmailVerification();
  }

  /// Reload Status of user
  Future reloadStatusOfUser() async{
    await _firebaseAuth.currentUser!.reload();
  }

  /// Sign In as anon
 Future signInAnon() async{
   try{
     UserCredential result = await _firebaseAuth.signInAnonymously();
      User? user = result.user;
     DatabaseServicePerson().addUser(user!, "patient");
    return getUserFromFirebase(user);

   }catch(e){
     return null;
   }
 }

  /// sign out
 Future singOut() async{
     try{
      final result = await _firebaseAuth.signOut();

     }catch(e){
       return null;
     }
 }



}