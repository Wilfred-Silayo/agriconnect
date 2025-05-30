import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/providers/userdata.dart';
import 'package:agriconnect/screens/authscreens/loginpage.dart';
import 'package:agriconnect/screens/buyerhome.dart';
import 'package:agriconnect/screens/farmerhome.dart';
import 'package:agriconnect/screens/selerHomeScreen.dart';
import 'package:provider/provider.dart';

class AuthFunction {
  final supabase = Supabase.instance.client;

  Future<String?> getUserRole(String email) async {
    final response = await supabase
        .from('Users')
        .select('userrole')
        .eq('email', email)
        .single();

    if (response != null && response['userrole'] != null) {
      return response['userrole'] as String;
    }
    return null;
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user != null) {
        String? userRole = await getUserRole(user.email!);

        if (userRole == 'Mkulima') {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => FarmerPage()));
        } else if (userRole == 'Buyer') {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => BuyerHomePage()));
        }
      }
    } on AuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Check your credentials.')),
      );
    }
  }

  Future<Object> homeDirectory() async {
    final session = supabase.auth.currentSession;
    final user = session?.user;

    if (user != null) {
      String? userRole = await getUserRole(user.email!);
      if (userRole == 'Mkulima') {
        return FarmerPage();
      } else if (userRole == 'Buyer') {
        return BuyerHomePage();
      }
    }

    return '';
  }

  Future<void> signUp(
    BuildContext context,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String userRole,
    String userLocation,
  ) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user != null) {
        await saveUserData(
          firstName,
          lastName,
          email,
          phoneNumber,
          userRole,
          userLocation,
        );

        Provider.of<UserDetails>(context, listen: false).setUserRole(userRole);

        if (userRole == 'Mkulima') {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => FarmerPage()));
        } else if (userRole == 'Buyer') {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => BuyerHomePage()));
        }
      }
    } on AuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up failed. Please try again.')),
      );
    }
  }

  Future<void> saveUserData(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String userRole,
    String userLocation,
  ) async {
    await supabase.from('Users').insert({
      'name': '$firstName $lastName',
      'email': email,
      'phone': phoneNumber,
      'userrole': userRole,
      'location': userLocation,
      'Crops': 'Mazao 1',
    });
  }

  Future<void> logOut() async {
    await supabase.auth.signOut();
    print('Signed out');
  }
}
