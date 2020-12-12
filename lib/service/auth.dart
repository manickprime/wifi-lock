import 'package:firebase_auth/firebase_auth.dart';
import 'package:wifi_lock/models/user.dart';
import 'package:wifi_lock/service/database.dart';
// import 'package:firebase_auth_web/firebase_auth_web.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //this one creates an user(we defined in models) object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, name: 'example') : null;
  }

  // String _uid

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // DatabaseService dbService = DatabaseService(uid: user.uid);
      // dbService.insertNewUserData('ria', 'ria', 'ria');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //to sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
