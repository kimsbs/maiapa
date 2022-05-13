import 'dart:async';
import 'package:flutter/material.dart';

import 'package:chat_pr/chat_page.dart';

// Call _HomeScreenState()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// HomeScreen UI
class _HomeScreenState extends State<HomeScreen> {

  var isSplash = 1;
  var opacityValue = 0.0;

  @override
  void initState() {
    super.initState();
    _delay();
  }

  // Delay 1 sec to change screen
  _delay() {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() =>
      {
        opacityValue = 1.0,
      });
    });
    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() => {
            isSplash = 2,
          });
    });
  }

  // HomeScreen Constructor
  @override
  Widget build(BuildContext context) {

    // SplashScreen
    if (isSplash == 1) {
      return Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          body: Center(
            child: AnimatedOpacity(
              opacity: opacityValue,
              duration: Duration(seconds: 1),
              child: Image.asset('asset/img/SScreen1.png'),
            )
          ));
    }

    // Home Screen After Splash Screen
    else {
      return Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
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
                  Container(
                    // 아이콘
                      width: 274,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Container(
                        child: Image.asset('asset/img/logo.png'),
                      )),
                  SizedBox(height: 130),
                  InkWell(
                    onTap: () {
                      Press_Chat(context);
                    },
                    child: Container(
                      // 버튼
                      width: 330,
                      height: 66,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF00b050), //Color(0xff00b050),
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
                            width: 274,
                            height: 50,
                            child: Text(
                              "진단채팅 시작하기",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 최근 탐색 기록 버튼
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      //Go_to_Log(context);
                    },
                    child: Container(
                      // 버튼
                      width: 325,
                      height: 66,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color(0xFF00b050),
                          width: 2,
                        ),
                        color: Colors.white, //Color(0xff00b050),
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
                            width: 270,
                            height: 50,
                            child: Text(
                              "최근 탐색 기록",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF00b050),
                                fontSize: 30,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }
  }
}

// Open Chat
// Call chat_page/ChatPage()
void Press_Chat(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatPage(),
    ),
  );
}
