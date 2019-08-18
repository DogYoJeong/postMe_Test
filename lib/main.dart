import 'package:flutter/material.dart';
import 'package:postme_test/PostMe.dart';


void main () {
  runApp(MaterialApp(
      title: 'Post Me!',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
        initialRoute: '/',
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