import 'package:flutter/material.dart';
import 'package:agriconnect/screens/productview.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String pricelable;
  final String productlabel;
  ProductCard({super.key, required this.imageUrl,required this.productlabel,required this.pricelable});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductView()));
      },
      child: Card(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/6,
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey,),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(widget.imageUrl),
                    ),
                  ),
                ),
                Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                     widget.productlabel,
                      style: TextStyle(color: Colors.white),
                    ))),
    
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    widget.pricelable,
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                )
                // Container(child: Text(''),)
              ]),
            ),
    );
  }
}