// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:agriconnect/screens/authscreens/buyerregister.dart';
import 'package:agriconnect/screens/authscreens/farmerregister.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class SelectAccountType extends StatelessWidget {
  const SelectAccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 3),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'KARIBU',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Kujiunga na Mfumo sahihhi unao mkutanisha Mkulima na Mfanya Biashara wa mazao kwa wakati sahihi na usalama',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 5),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FarmerRegPage()));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: ConstantsColors().mainColor(),
                    border: Border.all(color: Colors.grey, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  'Mkulima',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 5),
            child: InkWell(
               onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BuyerRegPage()));
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    border: Border.all(color: Colors.grey, width: 3),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  'Mfanyabiashara',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
