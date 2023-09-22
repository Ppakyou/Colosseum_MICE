import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localtest_1/chat/chat_lobby.dart';
import 'package:localtest_1/chat/message.dart';
import 'package:localtest_1/chat/new_message.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localtest_1/login/loginpage.dart';

class DUMMY extends StatefulWidget {
  const DUMMY({Key? key}) : super(key: key);

  @override
  _DUMMYState createState() => _DUMMYState();
}

class _DUMMYState extends State<DUMMY> {
  //구글 로그인 관련===========
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
  //==============

  //final _authentication = FirebaseAuth.instance; //아래의 _authentication 을 모두 googleSignIn 으로 바꿈
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = googleSignIn.currentUser;
      if (user != null) {
        //loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DUMMY SCREEN'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              //8/9 작성한 로그아웃 후 이전 페이지로 가는 알고리즘
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatScreen();
                  },
                ),
              );
              //8/9====================

              //Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
