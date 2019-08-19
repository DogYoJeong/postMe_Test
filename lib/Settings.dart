import 'package:flutter/material.dart';
//import 'package:postme_test/main.dart';

class SettingPage extends StatefulWidget {
  //DropDownButton에서 보낸거 받기
  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Center(child: Text('Settings', textAlign: TextAlign.center)),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, int index) {
          return ListTile (
            leading: Column(
              children: <Widget>[
                Text('124'),
              ],
            ),
            title: Text('455'),
            subtitle: Text('5555'),
            onTap: () {
              if(_settingShowAlert != null) {
                _settingShowAlert(context);
              }
              /*Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => false);*/
            },
          );
        },
      )
    );
  }
  void _settingDialog(SettingDialogAction value) {
    Navigator.of(context).pop();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => ()), (route) => false);
    //Navigator.pu
  }
  void _settingShowAlert(BuildContext) {
    showDialog(
        context: context,
      builder: (_) => AlertDialog(
        title: Text('Alert'),
        content: Text('Do you want to QUIT?', style: TextStyle(fontSize: 18.0),),
        actions: <Widget>[
          FlatButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
          FlatButton(onPressed: () {_settingDialog(SettingDialogAction.yes);}, child: Text('Confirm')),
        ],
      )
    );
  }
}

enum SettingDialogAction{
  yes,
  no,
}