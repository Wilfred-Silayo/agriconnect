import 'package:flutter/material.dart';


class LoadingBox extends StatefulWidget {
  const LoadingBox({super.key});

  @override
  State<LoadingBox> createState() => _LoadingBoxState();
}

class _LoadingBoxState extends State<LoadingBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alert'),
      content: Text('This is an alert message.'),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  
}