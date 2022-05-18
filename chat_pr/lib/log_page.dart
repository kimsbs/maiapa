import 'package:flutter/material.dart';

class logPage extends StatefulWidget {
  @override
  State<logPage> createState() => _SearchlogState();
}

class _SearchlogState extends State<logPage> {
  final DateTime historyDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff00b050),
        title: Center(
          child: Image.asset(
            'asset/img/chat_logo.png',
            fit: BoxFit.contain,
            height: 50,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xff00b050),
      body: Column(
        children: [
          _titlebar(),
          Expanded(
            child: Container(
              color: Color(0xffeeeeee),
              child: Stack(children: [
                ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8.0);
                    },
                    itemCount: 20, //검색 기록 개수 수정 요망
                    itemBuilder: (context, int index) {
                      return InkWell(
                        onTap: () {
                          //검색했던 병원 지도가서 보기;
                        },
                        child: Container(
                          decoration: _Log_Decoration(),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("여기에 검색기록을 넣을 거에요."),
                          ),
                        ),
                      );
                    }),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titlebar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SizedBox(
        height: 35,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            "최근 탐색 기록",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _Log_Decoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: 1.0,
        color: Colors.green,
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
}
