import 'package:flutter/material.dart';

void Press_Map(BuildContext context, String text) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SecondRoute(text: text),
    ),
  );
}

class SecondRoute extends StatelessWidget {
  SecondRoute({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
          child: Text('$text'),
        ),
    );
  }
}