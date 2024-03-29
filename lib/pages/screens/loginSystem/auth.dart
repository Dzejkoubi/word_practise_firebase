import 'package:firebase_auth/firebase_auth.dart';
import 'package:word_practise_firebase/pages/screens/loginSystem/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object

  // create MyUser object based on User
  MyUser? _userfromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
    //sign in w email & password

    //register in w email & password

    //sign out
  }
}
