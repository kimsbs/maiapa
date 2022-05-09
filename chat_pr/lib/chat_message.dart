import 'package:flutter/material.dart';

import 'check_valid.dart';
import 'map_page.dart';

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

    output = Is_rightInput(txt);
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
            //output 의 종류에 따라 Map버튼 유무.
            output != "오류" ? _Case_Map(context) : _Non_Case_Map()
          ],
        ),
      ),
    ];
  }

  //사용자의 입력메세지.
  @override
  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              decoration: _Chat_Decoration(type),
              child: Text(txt),
            ),
          ],
        ),
      ),
    ];
  }

  //응답 메세지중 지도 버튼을 출력하지 않는 경우.
  Widget _Non_Case_Map() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5.0),
      decoration: _Chat_Decoration(type),
      child: Text("정확한 값을 입력해주세요"),
    );
  }

  //응답메세지중, 지도 버튼을 출력하는 경우.
  Widget _Case_Map(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 5.0),
      decoration: _Chat_Decoration(type),
      child: Column(
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
              Press_Map(context, txt);
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration _Chat_Decoration(bool type) {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.green,
        ),
        borderRadius: _Radious_case(type));
  }

  BorderRadius _Radious_case(bool type) {
    if (type)
      return BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      );
    else
      return BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      );
  }
}
