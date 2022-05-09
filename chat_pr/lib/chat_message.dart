import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.txt, required this.type});

  final String txt;
  final bool type;

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }

  @override
  List<Widget> otherMessage(context) {
    final String output;

    output = _Is_rightInput(txt);
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: Text('B')),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("마이아파", style: TextStyle(fontWeight: FontWeight.bold)),
            if (output != "오류") _Case_Map() else _Non_Case_Map()
          ],
        ),
      ),
    ];
  }

  @override
  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(txt),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _Non_Case_Map() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.green,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
      child: Text("정확한 값을 입력해주세요"),
    );
  }

  Widget _Case_Map() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.green,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$txt 를 검색한 결과입니다.",
          ),
          OutlinedButton(
            child: Text("지도에서 보기"),
            style: OutlinedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () {
              _Press_Map();
            },
          ),
        ],
      ),
    );
  }

  String _Is_rightInput(String text) {
    if (text == "지도")
      return "지도";
    else
      return "오류";
  }

  void _Press_Map() {
    print("지도열기");
  }
}
