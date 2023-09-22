//구글 로그인용 파일
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:localtest_1/chat/chat_lobby.dart';
// import 'dart:developer' as developer;
// import 'package:localtest_1/login/google_sign_in_api.dart';

// class Login_auth_chat_lobby {
//   Future<UserCredential?> loginWithGoogle(BuildContext context) async {
//     GoogleSignInAccount? user = await GoogleSignInApi.login();

//     GoogleSignInAuthentication? googleAuth = await user!.authentication;
//     var credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

//     UserCredential? userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);

//     if (userCredential != null) {
//       print('로그인 성공 === Google');
//       print(userCredential);

//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => ChatScreen(userCredential: userCredential)));
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('로그인 실패 === Google')));
//     }
//     return userCredential;
//   }
// }
