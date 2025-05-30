// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:agriconnect/screens/jamiipage.dart';
import 'package:agriconnect/screens/marketpage.dart';
import 'package:agriconnect/screens/postScreen.dart';
import 'package:agriconnect/screens/profilescreen.dart';
import 'package:agriconnect/utilities/constantscolors.dart';
import 'package:agriconnect/widgets/homegridIcon.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {

 
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(169, 44, 188, 255),
                    border: Border.all(
                        color: Color.fromARGB(169, 44, 188, 255), width: 3),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage('assets/wingu.png'),
                        fit: BoxFit.fill),
                  ),
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Stack(children: [
                    Positioned(
                        left: 10,
                        top: 10,
                        child: Text(
                          'Weather',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 76, 86, 175)),
                        )),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: Text(
                          'Dar es salaam',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 76, 86, 175)),
                        )),
                    Positioned(
                        left: 10,
                        bottom: 10,
                        child: Text(
                          '23 C',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ))
                  ]),
                )),
            Container(
              height: MediaQuery.of(context).size.height,
              child: GridView.count(
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MarketPage()));
                    },
                    child: GridIconOne(
                      iconData: Icons.shopping_cart,
                      iconLable: 'Sokoni',
                    ),
                  ),
                  GridIconOne(
                    iconData: Icons.info_outline_rounded,
                    iconLable: 'Taarifa',
                  ),
                  GridIconOne(
                    iconData: Icons.shopping_cart,
                    iconLable: 'Mikopo',
                  ),
                   InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>JamiiPage()));
                    },
                    child: GridIconOne(
                      iconData: Icons.people,
                      iconLable: 'Jamii',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),       
      ),
    );
  }
}
