import 'package:flutter/material.dart';

import 'package:chat_pr/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<ChatMessage> _chats = [];

  @override
  Widget build(BuildContext context) {
    if (_chats.isEmpty) {
      _Add_chat("/도움", false);
    }
    return Scaffold(
      backgroundColor: Color(0xff00b050),
      body: Column(
        children: [
          Container(
            color: Color(0xff00b050),
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            color: Color(0xff00b050),
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('asset/img/chat_logo.png'),
          ),
          _highlightbar(),
          Flexible(
            flex: 7,
            child: Container(
              color: Color(0xffeeeeee),
              child: ListView.builder(
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
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
        height: MediaQuery.of(context).size.height * 0.055,
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
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffeeeeee),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextField(
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
