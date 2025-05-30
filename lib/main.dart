// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:agriconnect/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:agriconnect/providers/userdata.dart';
import 'package:agriconnect/screens/authscreens/accounttypepage.dart';
import 'package:agriconnect/screens/authscreens/loginpage.dart';
import 'package:agriconnect/screens/buyerhome.dart';
import 'package:agriconnect/screens/farmerhome.dart';
import 'package:agriconnect/screens/postScreen.dart';
import 'package:agriconnect/screens/profilescreen.dart';
import 'package:agriconnect/screens/select_crop_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => UserDetails(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: user == null ? 'login' : 'home',
      routes: {
        'home': (context) {
          checkAuthorization();
          String rew = Provider.of<UserDetails>(context).userRole.toString();
          if (rew == 'Mkulima') {
            return FarmerPage();
          } else {
            return BuyerHomePage();
          }
        },
        'profile': (context) => ProfileScreen(),
        'postscreen': (context) => PostPage(),
        'cropchoice': (context) => SelecteCropPage(),
        'login': (context) => LoginPage(),
        'register': (context) => SelectAccountType(),
        'buyer': (context) => BuyerHomePage()
      },
    );
  }

  Future<void> checkAuthorization() async {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email;

    if (email != null) {
      final response = await Supabase.instance.client
          .from('users')
          .select('role')
          .eq('email', email)
          .single();

      final role = response['role'];
      Provider.of<UserDetails>(context, listen: false).setUserRole(role);
      print(role);
    }
  }
}
