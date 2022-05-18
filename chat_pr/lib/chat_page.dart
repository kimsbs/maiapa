import 'package:flutter/material.dart';

import 'package:chat_pr/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<ChatMessage> _chats = [];
  final DateTime historyDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (_chats.isEmpty) {
      _Add_chat("/도움", false);
    }
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
          _highlightbar(),
          Expanded(
            child: Container(
              color: Color(0xffeeeeee),
              child:
                ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _chats[index],
                itemCount: _chats.length,
              ),

            ),
          ),
          Container(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 7),
                  _Chattab(),
                  SizedBox(height: 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _highlightbar() {
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
            "진단채팅",
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

  Widget _Chattab() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffeeeeee),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8),
              ),
              controller: _textEditingController,
              onSubmitted: _handleSubmitted,
              maxLines: 3,
              minLines: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  _handleSubmitted(_textEditingController.text);
                }
              },
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textEditingController.clear();
    _Add_chat(text, true); // my_message
    _Add_chat(text, false); // response_message
  }

  void _Add_chat(String text, bool type) {
    ChatMessage newchat = ChatMessage(
      txt: text,
      type: type,
    );
    setState(() {
      _chats.insert(0, newchat);
    });
  }
}
