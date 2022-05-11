import 'package:flutter/material.dart';

import 'package:chat_pr/chat_message.dart';

class ChatPage extends StatefulWidget{
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textEditingController = TextEditingController();
  List<ChatMessage> _chats = [];

  @override
  Widget build(BuildContext context){
    if(_chats.isEmpty)
      _Add_chat("/도움", false);
    return Scaffold(
      appBar : AppBar(
        centerTitle: true,
        title : Text("마이아파"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _chats[index],
                  itemCount: _chats.length,
                )),
            Divider(height: 1.0,),
            Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildInserttab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInserttab(){
    return Row(
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
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: (){
              if(_textEditingController.text.isNotEmpty)
                _handleSubmitted(_textEditingController.text);
            },
            color: Colors.green,
          ),
        )
      ],
    );
  }

  void _handleSubmitted(String text){
    _textEditingController.clear();
    _Add_chat(text, true); // my_message
    _Add_chat(text, false); // response_message
  }

  void _Add_chat(String text, bool type){
    ChatMessage newchat = ChatMessage(
      txt: text,
      type: type,
    );
    setState(() {
      _chats.insert(0, newchat);
    });
  }
}