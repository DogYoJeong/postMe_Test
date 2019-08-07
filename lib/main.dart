import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postme_test/PostMe.dart';


void main () {
  runApp(MaterialApp(
      title: 'Post Me!',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
        initialRoute: '/', // 아직 필요는 없지만 필요할 것 같아서...
        routes: {
          '/': (context) => FirstPage(),
        },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Me!',
      theme: ThemeData(
        primaryColor: Colors.purple,
        //어떻게 쓰는지 모르겠음...
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.purple,
        body: Center(
          child: RaisedButton(
              child: Text('PostMe Page!'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => PostPage()), (route) => false);
              }
              )
        )
    );
  }
}