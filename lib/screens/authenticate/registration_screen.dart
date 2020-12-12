import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wifi_lock/models/user.dart';
import 'package:wifi_lock/navigation_screens/main_page.dart';
import 'package:wifi_lock/service/auth.dart';
import 'package:wifi_lock/service/database.dart';

enum genderName { male, female, others }

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  final Function toggleView;

  RegistrationScreen({this.toggleView});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  var msgController = TextEditingController();
  final AuthService _authService = AuthService();
  final fnameController = TextEditingController(),
      mnameController = TextEditingController(),
      lnameController = TextEditingController();
  String email,
      password,
      retypePassword,
      firstName,
      lastName,
      middleName,
      gender,
      userName,
      alternativeEmail,
      phoneNum,
      alternatePhoneNum,
      doorNo,
      streetName,
      locality,
      city,
      district,
      state,
      pin,
      aadharCard,
      dlNO,
      pan;
  bool showProgress = false;

  genderName _character = genderName.male;

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    print("im in registration screen");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'wifi-lock',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: showProgress
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          FlatButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            child: Text('Login'),
                          ),
                          Text(
                            'Registration form',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Name'),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (val) =>
                                val.isEmpty ? 'enter First Name' : null,
                            onChanged: (value) {
                              firstName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'First Name',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              middleName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Middle Name',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (val) =>
                                val.isEmpty ? 'enter last Name' : null,
                            onChanged: (value) {
                              lastName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Gender'),
                          ListTile(
                            title: Text('Male'),
                            leading: Radio(
                              value: genderName.male,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                  gender = 'Male';
                                });
                              },
                            ),
                            dense: true,
                          ),
                          ListTile(
                            title: Text('Female'),
                            leading: Radio(
                              value: genderName.female,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                  gender = 'Female';
                                });
                              },
                            ),
                            dense: true,
                          ),
                          ListTile(
                            title: Text('Others'),
                            leading: Radio(
                              value: genderName.others,
                              groupValue: _character,
                              onChanged: (value) {
                                setState(() {
                                  _character = value;
                                  gender = 'Others';
                                });
                              },
                            ),
                            dense: true,
                          ),
                          Text('DOB'),
                          Text("${selectedDate.toLocal()}".split(' ')[0]),
                          RaisedButton(
                            onPressed: () => _selectDate(context),
                            child: Text('Select DOB'),
                          ),
                          Text('Username'),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (val) =>
                                val.isEmpty ? 'Please enter an username' : null,
                            onChanged: (value) {
                              userName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your username',
                            ),
                          ),
                          Text('Password'),
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (val) => val.length < 6
                                ? 'Enter a password with 6+ char'
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                            ),
                          ),
                          Text('Re-type Password'),
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              retypePassword = value;
                            },
                            validator: (val) => val.length < 6
                                ? 'Enter the above password'
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Re-type your password',
                            ),
                          ),
                          Text('Email'),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            validator: (val) =>
                                val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                            ),
                          ),
                          Text('Alternative email'),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            // validator: (val) =>
                            // val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              alternativeEmail = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter an alternative email',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Phone No'),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            // validator: (val) =>
                            // val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              phoneNum = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your phone No',
                            ),
                          ),
                          Text('Alternate Phone No'),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            // validator: (val) =>
                            // val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              alternatePhoneNum = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter alternate phone No',
                            ),
                          ),
                          Text('Address'),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            // validator: (val) =>
                            // val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              doorNo = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your Door no',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your street name'
                                : null,
                            onChanged: (value) {
                              streetName = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your street no',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            // validator: (val) =>
                            // val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              locality = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your locality',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: msgController,
                            textAlign: TextAlign.center,
                            validator: (val) =>
                                val.isEmpty ? 'Please enter your city' : null,
                            onChanged: (value) {
                              city = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your city',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            // validator: (val) =>
                            // val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              district = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your district',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (val) =>
                                val.isEmpty ? 'Please enter your state' : null,
                            onChanged: (value) {
                              state = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your state',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your PIN code'
                                : null,
                            onChanged: (value) {
                              pin = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your PIN code',
                            ),
                          ),
                          Text('Identification Details'),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            validator: (val) => val.isEmpty
                                ? 'Please enter your aadhar card no'
                                : null,
                            onChanged: (value) {
                              aadharCard = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your aadhar card No',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            // validator: (val) =>
                            // val.isEmpty ? 'Please enter an email' : null,
                            onChanged: (value) {
                              dlNO = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your driver license no',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            validator: (val) =>
                                val.isEmpty ? 'Please enter PAN card No' : null,
                            onChanged: (value) {
                              pan = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your PAN card No',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            child: Text('Clear'),
                            onPressed: () {
                              setState(() {
                                email = "";
                                password = "";
                                retypePassword = "";
                                firstName = "";
                                lastName = "";
                                middleName = "";
                                userName = "";
                                alternativeEmail = "";
                                phoneNum = "";
                                alternatePhoneNum = "";
                                doorNo = "";
                                streetName = "";
                                locality = "";
                                city = "";
                                district = "";
                                state = "";
                                pin = "";
                                aadharCard = "";
                                dlNO = "";
                                pan = "";

                                _character = genderName.male;

                                selectedDate = DateTime.now();
                              });
                              msgController.clear();
                              // print(city);
                            },
                          ),
                          FlatButton(
                            color: Colors.grey,
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              try {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    showProgress = true;
                                  });
                                }
                                User newUser = await _authService
                                    .registerWithEmailAndPassword(
                                        email, password);

                                // String uid = user.uid;
                                DatabaseService dbService =
                                    DatabaseService(uid: newUser.uid);
                                dbService.insertNewUserData(
                                    fname: firstName,
                                    mname: middleName,
                                    lname: lastName,
                                    gender: gender,
                                    dob: selectedDate,
                                    username: userName,
                                    altEmail: alternativeEmail,
                                    phoneNum: phoneNum,
                                    altPhoneNum: alternatePhoneNum,
                                    address: (doorNo +
                                        "," +
                                        streetName +
                                        "," +
                                        locality +
                                        "," +
                                        district +
                                        "," +
                                        state +
                                        "(" +
                                        pin +
                                        ")"),
                                    aadharNum: aadharCard,
                                    panNum: pan,
                                    driverLicNum: dlNO);
                                if (newUser != null) {
                                  setState(() {
                                    showProgress = false;
                                  });
                                  Navigator.pushNamed(context, MainPage.id);
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
