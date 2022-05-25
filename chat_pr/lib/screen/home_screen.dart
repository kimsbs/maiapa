import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chat_pr/chat_page.dart';
import 'package:chat_pr/log_page.dart';

// Call _HomeScreenState()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// HomeScreen UI
class _HomeScreenState extends State<HomeScreen> {
  // HomeScreen Constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: SizedBox(
          // 아이콘, 버튼 포함
          width: 330,
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              main_page_logo(),
              const SizedBox(height: 130),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(_createRoute_chat());
                },
                child: chat_button(),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(_createRoute_log());
                },
                child: searched_button(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container main_page_logo() {
    return Container(
      width: 274,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Image.asset('asset/img/logo.png'),
    );
  }

  Container chat_button() {
    return Container(
      width: 330,
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF00b050), //Color(0xff00b050),
      ),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Center(
              child: _TextStyle("진단채팅 시작하기", 0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }

  Container searched_button() {
    return Container(
      // 버튼
      width: 325,
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF00b050),
          width: 2,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(
        left: 26,
        right: 25,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Center(
              child: _TextStyle("최근 탐색 기록", 0xFF00b050),
            ),
          ),
        ],
      ),
    );
  }

  Text _TextStyle(String txt, int color_val) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(color_val),
        fontSize: 30,
        fontFamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// Open Chat
// Call chat_page/ChatPage()
Route _createRoute_chat() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ChatPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute_log() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => logPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);

      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
