import 'package:flutter/material.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class GridIconOne extends StatelessWidget {
  String iconLable;
  IconData iconData;
  GridIconOne({super.key, required this.iconLable, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 45,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 75,
                color: ConstantsColors().mainColor(),
              ),
              Text(iconLable,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
