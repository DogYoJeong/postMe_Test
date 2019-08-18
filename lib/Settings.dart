import 'package:flutter/material.dart';
import 'package:postme_test/main.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Center(child: Text('Settings', textAlign: TextAlign.center)),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => false);
          },
            child: Text('FirstPage'),
          ),
      )
    );
  }
}