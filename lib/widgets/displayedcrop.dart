import 'package:flutter/material.dart';
import 'package:agriconnect/utilities/constantscolors.dart';

class DisplayedCrop extends StatefulWidget {
  String farmeremail;
  String bei;
  String zao;
  String phone;
  
  DisplayedCrop({required this.farmeremail, required this.bei, required this.zao, required this.phone});

  @override
  State<DisplayedCrop> createState() => _DisplayedCropState();
}

class _DisplayedCropState extends State<DisplayedCrop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: ConstantsColors().mainColor(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Email:  ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.farmeremail,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_in_talk_outlined,
                            color: ConstantsColors().mainColor(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Simu:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.phone,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: ConstantsColors().mainColor(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Bei: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.bei,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: ConstantsColors().mainColor(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Zao:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.zao,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: ConstantsColors().mainColor(),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Location: ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('Tanzania',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
