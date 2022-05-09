import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'check_valid.dart';
import 'map_page.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.txt, required this.type});

  final String txt;
  final bool type;
  final Chat_padding_val = EdgeInsets.all(5);
  final Chat_margin_val = const EdgeInsets.only(top: 3);

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : responseMessage(context),
      ),
    );
  }

  //응답 메세지
  @override
  List<Widget> responseMessage(context) {
    //현재 화면의 가로길이
    double width = MediaQuery.of(context).size.width;
    final Tuple2<String, bool> output;
    //Is_rightInput에서 들어온 text판별 정상유무는 bool에 저장.
    output = Is_rightInput(txt);
    return <Widget>[
      //봇의 이미지.
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: Text('마')),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //봇의 이름
            Text("마이아파", style: TextStyle(fontWeight: FontWeight.bold)),
            //output 의 종류에 따라 Map버튼 유무.
            output.item2 != false ? _Case_Map(context, width) : _Non_Case_Map(width, output.item1)
          ],
        ),
      ),
    ];
  }

  //사용자의 입력메세지.
  @override
  List<Widget> myMessage(context) {
    double width = MediaQuery.of(context).size.width;

    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ConstrainedBox(
              constraints: _Max_width_percent(width),
              child: Container(
                padding: Chat_padding_val,
                decoration: _Chat_Decoration(type),
                child: Text(txt),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  //응답 메세지 지도 버튼을 출력하지 않는 경우.
  Widget _Non_Case_Map(double width, String output) {
    return ConstrainedBox(
      constraints: _Max_width_percent(width),
      child: Container(
        padding: Chat_padding_val,
        margin: Chat_margin_val,
        decoration: _Chat_Decoration(type),
        child: Text("$output"),
      ),
    );
  }

  //응답메세지가 지도 버튼을 출력하는 경우.
  Widget _Case_Map(BuildContext context, double width) {
    return ConstrainedBox(
      constraints: _Max_width_percent(width),
      child: Container(
        padding: Chat_padding_val,
        margin: Chat_margin_val,
        decoration: _Chat_Decoration(type),
        child: Column(
          children: [
            Text("$txt 를 검색한 결과입니다."),
            OutlinedButton(
              child: Text("지도에서 보기"),
              style: OutlinedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                Press_Map(context, txt);
              },
            ),
          ],
        ),
      ),
    );
  }

  //사용자, 봇 에따른 말풍선 모양
  BorderRadius _Radious_case(bool type) {
    //my_message
    if (type)
      return BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      );
    //other_message
    else
      return BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      );
  }

  //채팅 틀
  BoxDecoration _Chat_Decoration(bool type) {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.7,
          color: Colors.green,
        ),
        borderRadius: _Radious_case(type));
  }

  //채팅 블록 최대사이즈
  BoxConstraints _Max_width_percent(double width) {
    return BoxConstraints(
      maxWidth: width * 0.7,
    );
  }
}
