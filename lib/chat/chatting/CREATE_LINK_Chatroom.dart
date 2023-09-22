import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localtest_1/chat/chat_lobby.dart';
import 'package:localtest_1/chat/message.dart';
import 'package:localtest_1/chat/new_message.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localtest_1/login/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';

//링크 생성
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CREATELINKChatroom extends StatefulWidget {
  const CREATELINKChatroom({Key? key}) : super(key: key);

  @override
  _CREATELINKChatroomState createState() => _CREATELINKChatroomState();
}

class _CREATELINKChatroomState extends State<CREATELINKChatroom> {
  //구글 로그인 관련===========
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
  //==============

  //익명 로그인 관련=========

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String _invitationLink = '';

  Future<void> _createGroupAndGenerateLink() async {
    // Get the current user's ID
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      return; // Handle user not authenticated
    }

    // Create a new group document in Firestore
    final groupRef = _firestore.collection('groups').doc();
    final groupId = groupRef.id;

    // Add the current user as a member of the group
    await groupRef.set({
      'members': [currentUser.uid],
      // Add more group information here
    });

    // Generate an invitation link
    final invitationLink = 'https://localhost1.page.link/$groupId';

    setState(() {
      _invitationLink = invitationLink;
    });

    // Store the invitation link in Firestore
    await groupRef.update({'invitationLink': invitationLink});
  }

  //============

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
        title: Text('CREATE LINK Chatroom'),
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
      body: Column(
        children: [
          SizedBox(
            child: Container(
              width: 400,
              height: 40,
              child: Text(
                'Invitation Link: $_invitationLink',
                style: TextStyle(fontSize: 10, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Expanded(
                  child: Messages(),
                ),
                NewMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
