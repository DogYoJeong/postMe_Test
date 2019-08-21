import 'package:flutter/material.dart';
import 'package:postme_test/PostMe.dart';
//import 'package:postme_test/Settings.dart'; //몇번 유저인지 정보 보내기

//TODO 생성,삭제,DropDonwButton(틀만), Settings(틀만) 완료 , 숙제 : items,sub 합치기 수정 데이터 setState 해주기
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

class FirstPage extends StatefulWidget {
  // DropDownButton의 value 값 보내기
  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  var _dropItem = ['???','User1','User2','User3','User4','User5','User6','User7','User8','User9','User10'];
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.purple,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Post ME!', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('You are', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                  DropdownButton<String>(
                    items: _dropItem.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
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
            ],
          )
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