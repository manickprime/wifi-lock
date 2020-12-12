import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userDataCollection =
      Firestore.instance.collection('userData');

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
