import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wifi_lock/models/online_user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userDataCollection =
      Firestore.instance.collection('userData');

  // Future createCollection({String uid}) async {
  //   // firestore
  // }

  OnlineUser _userFromFirebaseUser(FirebaseUser user){
    String userName,phoneNum;
    Firestore.instance
        .collection('userData')
        .document(uid)
        .get()
        .then((value) {
      userName = value.data['username'];
      phoneNum = value.data['phoneNum'];
    });
    return user!= null ? OnlineUser(userName: userName, phoneNum: phoneNum);
  }

  // Stream<OnlineUser> get onlineUser {
  //   return OnlineUser({});
  // }

  String getUserName({String uid}) {
    String name;
    Firestore.instance.collection('userData').document(uid).get().then((value) {
      name = value.data['username'];
      print("im from database and inside $name");
      // return value.data['username'];
    });
    print("im from database page $name");
    return name;
    // var firebaseUser = FirebaseAuth.instance.currentUser();
    // fire
  }

  Future getUser({String uid}) async {
    String userName, phoneNum;
    await Firestore.instance
        .collection('userData')
        .document(uid)
        .get()
        .then((value) {
      userName = value.data['username'];
      phoneNum = value.data['phoneNum'];
    });
    return OnlineUser(userName: userName, phoneNum: phoneNum);
  }

  Future openLog({String uid, DateTime currentTime}) async {
    final CollectionReference specificOpenLog =
        Firestore.instance.collection(uid);
    await specificOpenLog.document('flag').setData({
      'flag': 1,
    });
    // final CollectionReference specificOpenLog =
    //     Firestore.instance.collection(uid);
    // print(specificOpenLog);
    // await Firestore.instance
    //     .collection('uid')
    //     .document('VWD6fx7bwFB4rNhMn59J')
    //     .collection(uid)
    //     .add({
    //   'flag': 1,
    // });
    return await specificOpenLog.document('open').setData({
      'openTime': currentTime,
    });
  }

  // Future addInLog({String uid, DateTime currentTime, int flag}) async {
  //   final CollectionReference timesCountCol =
  //       Firestore.instance.collection(uid);
  //   int timeCount = times['times'];
  //   DocumentReference timesCountDoc = await timesCountCol.document('num').get();
  //   String log = times['log'];
  //   print(timeCount);
  //   timeCount++;
  //   log = log + '|$timeCount:$currentTime';
  //   return await timesCountDoc.setData({
  //     'times': timeCount,
  //     'log': log,
  //   });

  // final DocumentReference timesCountDoc =
  // Firestore.instance.collection(uid).document('num');
  // final DocumentSnapshot times = await timesCountDoc.get();
  // int timeCount = times['times'];
  // String log = times['log'];
  // print(timeCount);
  // timeCount++;
  // log = log + '|$timeCount:$currentTime';
  // return await timesCountDoc.setData({
  //   'times': timeCount,
  //   'log': log,
  // });
  // }

  Future closeLog({String uid, DateTime currentTime}) async {
    final CollectionReference specificOpenLog =
        Firestore.instance.collection(uid);
    await specificOpenLog.document('flag').setData({
      'flag': 0,
    });
    return await specificOpenLog.document('close').setData({
      'closeTime': currentTime,
    });
  }

  Future insertNewUserData(
      {String fname,
      String lname,
      String mname,
      String gender,
      DateTime dob,
      String username,
      String altEmail,
      String phoneNum,
      String altPhoneNum,
      String address,
      String aadharNum,
      String driverLicNum,
      String panNum}) async {
    return await userDataCollection.document(uid).setData({
      'fname': fname,
      'lname': lname,
      'mname': mname,
      'gender': gender,
      'dob': dob,
      'username': username,
      'atlEmail': altEmail,
      'phoneNum': phoneNum,
      'altPhoneNum': altPhoneNum,
      'address': address,
      'aadharNum': aadharNum,
      'driverLicenseNum': driverLicNum,
      'panNum': panNum
    });
  }
}
