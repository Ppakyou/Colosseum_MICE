import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localtest_1/chat/chat_lobby.dart';
import 'package:localtest_1/login/loginpage.dart';
import 'package:localtest_1/login/google_sign_in_api.dart';

class GoogleLoggedInPage extends StatelessWidget {
  final UserCredential userCredential;

  GoogleLoggedInPage({
    Key? key,
    required this.userCredential,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                await GoogleSignInApi.logout();

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ));
              },
            ),
            const Text(
              'Profile',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(userCredential.user?.photoURL ??
                    'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y')),
            const SizedBox(height: 8),
            Text(
              'Name: ${userCredential.user?.displayName}',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
