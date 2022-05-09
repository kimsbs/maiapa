import 'package:flutter/material.dart';

import 'package:chat_pr/chat_page.dart';

void main(){
  runApp(Home());
}

class Home extends StatelessWidget {
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

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: OutlinedButton(
          child: Text("채팅창 열기"),
          style: OutlinedButton.styleFrom(primary: Colors.green),
          onPressed: () {
            Press_Chat(context);
          },
        ),
      ),
    );
  }
}

void Press_Chat(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatPage(),
    ),
  );
}