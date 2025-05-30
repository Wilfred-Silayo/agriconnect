// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:agriconnect/screens/authscreens/autfunctions.dart';
import 'package:agriconnect/screens/select_crop_page.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FarmerRegPage extends StatefulWidget {
  FarmerRegPage({Key? key}) : super(key: key);

  @override
  State<FarmerRegPage> createState() => _FarmerRegPageState();
}

class _FarmerRegPageState extends State<FarmerRegPage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  bool _isLoading = false;

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _repassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantsColors().mainColor(),
        title: Text('Usajili wa Mkulima'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              // First Name Field
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                      child: Text(
                        'Jina la Kwanza',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: TextFormField(
                        controller: _firstName,
                        onChanged: (value) => _formkey.currentState?.validate(),
                        validator: (value) {
                          if (value!.isEmpty) return "Please Enter a name";
                          if (!RegExp(r'[a-zA-Z]{2,}').hasMatch(value)) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          hintText: 'Juma',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Last Name Field
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                      child: Text(
                        'Jina la Mwisho',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: TextFormField(
                        controller: _lastName,
                        onChanged: (value) => _formkey.currentState?.validate(),
                        validator: (value) {
                          if (value!.isEmpty) return "Please Enter a name";
                          if (!RegExp(r'[a-zA-Z]{2,}').hasMatch(value)) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          hintText: 'Kilungi',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Email Field
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                      child: Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: TextFormField(
                        controller: _email,
                        onChanged: (value) => _formkey.currentState?.validate(),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please Enter an Email Address";
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a Valid Email Address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Phone Number Field
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                      child: Text(
                        'Number ya Simu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: TextFormField(
                        controller: _phonenumber,
                        onChanged: (value) => _formkey.currentState?.validate(),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please Enter Phone Number";
                          if (!RegExp(
                                  r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid Phone Number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          hintText: '+255 67 890 786',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Password Field
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                      child: Text(
                        'Neno la Siri',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          hintText: '**********',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Confirm Password Field
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
                      child: Text(
                        'Rudia Neno la Siri',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: TextFormField(
                        controller: _repassword,
                        obscureText: true,
                        validator: (value) {
                          if (value != _password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2)),
                          hintText: '******',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Register Button
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      if (!_formkey.currentState!.validate()) return;

                      setState(() => _isLoading = true);
                      _loadingIndicator(_isLoading);

                      try {
                        await signUp(
                            _firstName.text,
                            _lastName.text,
                            _email.text,
                            _phonenumber.text,
                            _password.text,
                            'Mkulima',
                            'Tanzania');
                      } finally {
                        setState(() => _isLoading = false);
                      }
                    },
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Sajili',
                                style: TextStyle(
                                    fontSize: ConstantsColors().textSizeOne,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp(
      String firstName,
      String lastName,
      String email,
      String phonenumber,
      String password,
      String role,
      String userlocation) async {
    try {
      // Sign up with Supabase Auth
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (res.user != null) {
        // Save user data to Supabase database
        await userDataCollections(res.user!.id, firstName, lastName,
            phonenumber, email, role, userlocation);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SelecteCropPage()));
      }
    } on AuthException catch (e) {
      print('Auth error : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  Future<void> userDataCollections(
      String userId,
      String firstName,
      String lastName,
      String phonenumber,
      String email,
      String role,
      String userlocation) async {
    try {
      await _supabase.from('Users').insert({
        "id": userId,
        "name": "$firstName $lastName",
        "email": email,
        "phone": phonenumber,
        "userrole": role,
        "location": userlocation,
        "crops": "Mazao 1"
      });
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  void _loadingIndicator(bool isactive) {
    if (isactive) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tafadhali Subiri'),
            content: Container(
              height: MediaQuery.of(context).size.height / 5,
              child: Center(
                child: CircularProgressIndicator(
                  color: ConstantsColors().mainColor(),
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
