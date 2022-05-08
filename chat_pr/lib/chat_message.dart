import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.txt, required this.type});

  final String txt;
  final bool type;

  @override
  List<Widget> myMessage(context){
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(txt),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  List<Widget> otherMessage(context){
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: Text('B')),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("마이아파",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(txt),
            ),
          ],
        ),
      ),
    ];
  }

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}