import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:localtest_1/chat/chatting/CREATE_LINK_Chatroom.dart';
import 'package:localtest_1/chat/chatting/DUMMY.dart';
import 'package:localtest_1/chat/message.dart';
import 'package:localtest_1/chat/new_message.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localtest_1/login/loginpage.dart';
import 'package:localtest_1/palette/palette_login.dart';

//링크 생성 파트
//import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //구글 로그인 관련===========
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
  //==============

  //링크 생성 코드==========
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    final invitationLink = 'https://your-app-domain.com/invite/$groupId';

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
    //배경 + 메뉴 코드
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          //Container 내부는 배경 gif 삽입 코드
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/gif/WHITEWAVES.gif'),
              fit: BoxFit.fill,
            )),
          ),
          //아래는 메뉴 버튼 코드
          Container(
            // margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      // _createGroupAndGenerateLink;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DUMMY()));
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(200, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.purple,
                    ),
                    child: Text(
                      'CREATE LINK',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 175,
                        height: 80,
                        child: TextButton(
                            child: Text(
                              'Random Battle',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DUMMY())),
                            style: TextButton.styleFrom(
                              minimumSize: Size(200, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.orange,
                            )),
                      ),
                      SizedBox(width: 25),
                      SizedBox(
                        width: 175,
                        height: 80,
                        child: TextButton(
                            child: Text(
                              'Rank Battle',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DUMMY())),
                            style: TextButton.styleFrom(
                              minimumSize: Size(200, 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.orange,
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 300,
                    height: 80,
                    child: TextButton(
                        child: Text(
                          'Custom Game',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DUMMY())),
                        style: TextButton.styleFrom(
                          minimumSize: Size(200, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.orange,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: TextButton(
                        child: Text(
                          'Shop',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DUMMY())),
                        style: TextButton.styleFrom(
                          minimumSize: Size(200, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.red,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: TextButton(
                        child: Text(
                          'Settings',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DUMMY())),
                        style: TextButton.styleFrom(
                          minimumSize: Size(200, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.green,
                        )),
                  ),
                ),
              ],
            ),
          )
          //위는 메뉴 버튼 코드
        ],
      ),
      //배경 + 메뉴 버튼 코드
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              googleSignIn.signOut();
              //8/9 작성한 로그아웃 후 이전 페이지로 가는 알고리즘
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginSignupScreen();
                  },
                ),
              );
              //8/9====================

              //Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
