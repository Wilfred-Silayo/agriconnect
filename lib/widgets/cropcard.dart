import 'package:flutter/material.dart';

class SelectedCard extends StatefulWidget {
  final String cardlabel;
  final String imageUrl;
  final Color color;
  SelectedCard({super.key, required this.cardlabel, required this.imageUrl, required this.color});

  @override
  State<SelectedCard> createState() => _SelectedCardState();
}

class _SelectedCardState extends State<SelectedCard> {
bool _isSelected=false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSelected =true;
        });
      },
      child: Card(
        // ignore: prefer_const_constructors
        color: widget.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Container(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(widget.imageUrl),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.cardlabel,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: _isSelected ? Colors.green : Colors.grey,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
