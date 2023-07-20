import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
        elevation: 0.0,
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 50)),
          const Center(
            child: Image(
              image: AssetImage('assets/image/mqdl_test_nobg.png'),
              width: 170.0,
            ),
          ),
          Form(
              child: Theme(
            data: ThemeData(
                primaryColor: Colors.grey,
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0))),
            child: Container(
                padding: const EdgeInsets.all(40.0),
                // 키보드가 올라와서 만약 스크린 영역을 차지하는 경우 스크롤이 되도록
                // SingleChildScrollView으로 감싸 줌
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(labelText: 'Enter email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const TextField(
                        decoration:
                            InputDecoration(labelText: 'Enter password'),
                        keyboardType: TextInputType.text,
                        obscureText: true, // 비밀번호 안보이도록 하는 것
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ButtonTheme(
                          minWidth: 100.0,
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent),
                            child: const Icon(
                              Icons.login,
                              color: Colors.white,
                              size: 35.0,
                            ),
                          ))
                    ],
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
