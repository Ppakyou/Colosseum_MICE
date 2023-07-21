import 'package:flutter/material.dart';

class Chat_lobby extends StatefulWidget {
  const Chat_lobby({super.key});

  @override
  State<Chat_lobby> createState() => _Chat_lobby();
}

class _Chat_lobby extends State<Chat_lobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat screen'),
        ),
        body: const Center(
          child: Text('Chat screen'),
        ));
  }
}
