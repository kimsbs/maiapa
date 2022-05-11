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
  final double radious_value = 10;
  double screen_width = 0;

  Widget build(BuildContext context) {
    //현재 화면의 가로길이
    screen_width = MediaQuery.of(context).size.width;
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
    final Tuple2<String, int> output;
    //Is_rightInput에서 들어온 text판별 정상유무는 bool에 저장.
    output = Is_rightInput(txt);
    return <Widget>[
      //봇의 이미지.
      Container(
        margin: const EdgeInsets.only(right: 7.0),
        child: const CircleAvatar(
          backgroundImage: AssetImage('asset/img/maiapa.png'),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //봇의 이름
            const Text("마이아파", style: TextStyle(fontWeight: FontWeight.bold)),
            //output 의 종류에 따라 Map버튼 유무.
            output.item2 < 4 && output.item2 > 1 ? _Case_Map(context, output) : _Non_Case_Map(output.item1)
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
            ConstrainedBox(
              constraints: _Chat_Width_Control(),
              child: Container(
                padding: Chat_padding_val,
                decoration: _Chat_Decoration(),
                child: Text(txt),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  //응답 메세지 지도 버튼을 출력하지 않는 경우.
  Widget _Non_Case_Map(String output) {
    return ConstrainedBox(
      constraints: _Chat_Width_Control(),
      child: Container(
        padding: Chat_padding_val,
        margin: Chat_margin_val,
        decoration: _Chat_Decoration(),
        child: Text(output),
      ),
    );
  }

  //응답메세지가 지도 버튼을 출력하는 경우.
  Widget _Case_Map(BuildContext context, Tuple2<String, int> output) {
    return ConstrainedBox(
      constraints: _Chat_Width_Control(),
      child: Container(
        padding: Chat_padding_val,
        margin: Chat_margin_val,
        decoration: _Chat_Decoration(),
        child: Column(
          children: [
            Text("$txt 를 검색한 결과입니다."),
            OutlinedButton(
              child: const Text("지도에서 보기"),
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
  BorderRadius _Radious_case() {
    //my_message
    if (this.type) {
      return BorderRadius.only(
        topLeft: Radius.circular(radious_value),
        bottomRight: Radius.circular(radious_value),
        bottomLeft: Radius.circular(radious_value),
      );
    }
    //other_message
    else {
      return BorderRadius.only(
        topRight: Radius.circular(radious_value),
        bottomRight: Radius.circular(radious_value),
        bottomLeft: Radius.circular(radious_value),
      );
    }
  }

  //채팅 틀
  BoxDecoration _Chat_Decoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: 0.7,
        color: Colors.green,
      ),
      borderRadius: _Radious_case(),
    );
  }

  //채팅 블록 최대사이즈
  BoxConstraints _Chat_Width_Control() {
    if (this.type) {
      this.screen_width *= 0.75;
    } else {
      this.screen_width *= 0.65;
    }
    return BoxConstraints(maxWidth: screen_width);
  }
}
