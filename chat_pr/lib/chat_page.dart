import 'package:flutter/material.dart';

import 'package:chat_pr/chat_message.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  List<ChatMessage> _chats = [];

  @override
  Widget build(BuildContext context){
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
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: (){
              _handleSubmitted(_textEditingController.text);
            },
            color: Colors.green,
          ),
        )
      ],
    );
  }

  void _handleSubmitted(String text){
    if(text == "")
      return ;
    _textEditingController.clear();
    ChatMessage newchat = ChatMessage(
        txt : text,
        type : true,
    );
    setState(() {
      _chats.insert(0, newchat);
    });
    Response(text);
  }

  void Response(String text){
    ChatMessage newchat = ChatMessage(
      txt: text,
      type: false,
    );
    setState(() {
      _chats.insert(0, newchat);
    });
  }
}