import 'package:flutter/material.dart';
import 'package:agriconnect/screens/buyerhome.dart';
import 'package:agriconnect/screens/farmerhome.dart';

class DividerPage extends StatefulWidget {
  String role;
   DividerPage({super.key, required this.role});

  @override
  State<DividerPage> createState() => _DividerPageState();
}

class _DividerPageState extends State<DividerPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.role =='Mkulima'){
       return FarmerPage();
    }
    else{
      return  BuyerHomePage();
    }
  }
}