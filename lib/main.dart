import 'package:flutter/material.dart';
import 'package:postme_test/PostMe.dart';
import 'package:postme_test/Settings.dart';


void main () { //얘는 아직 안썼음
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

class FirstPage extends StatefulWidget {
  // DropDownButton의 value 값 보내기
  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.purple,
        body: Center(
          child: Row(
            children: <Widget>[
              Text('Your', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              DropdownButton(
                items: [
                  DropdownMenuItem(
                    value: "0",
                    child: Text(
                      "???",
                    ),
                  ),
                  DropdownMenuItem(
                    value: '1',
                    child: Text(
                      'User1',
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    //_value = value;
                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => PostPage()), (route) => false);
                  });
                },
                //value: _value,
              )
            ],
          ),
          /*RaisedButton(
              child: Text('PostMe Page!'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => PostPage()), (route) => false);
              }
              )*/
        )
    );
  }
}