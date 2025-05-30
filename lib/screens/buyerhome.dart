// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agriconnect/screens/buyerorderview.dart';
import 'package:agriconnect/screens/buyerscreen.dart';
import 'package:agriconnect/screens/marketpage.dart';
import 'package:agriconnect/screens/profilescreen.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class BuyerHomePage extends StatefulWidget {
  const BuyerHomePage({super.key});

  @override
  State<BuyerHomePage> createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State<BuyerHomePage> {
  int _currentIndex = 0;

  final List<Widget> _buyerpages = [
    BuyerScreen(),
    MarketPage(),
    BuyerOrders(),
    ProfileScreen()
  ];

  final user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buyerpages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 5,
          currentIndex: _currentIndex,
          selectedItemColor: ConstantsColors().mainColor(),
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          onTap: _onItemTapped,
          items: [
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
