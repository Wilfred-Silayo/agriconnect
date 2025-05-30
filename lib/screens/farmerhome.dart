// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/providers/userdata.dart';
import 'package:agriconnect/screens/selerHomeScreen.dart';
import 'package:agriconnect/screens/marketpage.dart';
import 'package:agriconnect/screens/postScreen.dart';
import 'package:agriconnect/screens/profilescreen.dart';
import 'package:agriconnect/screens/sellerorderview.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:agriconnect/widgets/homegridIcon.dart';
import 'package:provider/provider.dart';

class FarmerPage extends StatefulWidget {
  FarmerPage({super.key});

  @override
  State<FarmerPage> createState() => _FarmerPageState();
}

class _FarmerPageState extends State<FarmerPage> {
  int _currentIndex = 0;

  final List<Widget> _selerpages = [
    SelerScreen(),
    MarketPage(),
    SelerOrders(),
    ProfileScreen()
  ];

  final user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _selerpages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          currentIndex: _currentIndex,
          selectedItemColor: ConstantsColors().mainColor(),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Sokoni',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
