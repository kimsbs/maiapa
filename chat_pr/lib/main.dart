import 'package:flutter/material.dart';

import 'package:chat_pr/chat_page.dart';

void main(){
  runApp(Chatapp());
}

class Chatapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '마이아파',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
