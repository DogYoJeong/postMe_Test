import 'package:flutter/material.dart';
//import 'package:postme_test/main.dart';

/*class SettingPage extends StatefulWidget {

  //DropDownButton에서 보낸거 받기
  @override
  SettingPageState createState() => SettingPageState();
}*/

class SettingPage extends StatelessWidget {

  final List<String> items = <String>['You are (User n)','Developer','Version',];

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Center(child: Text('Settings', textAlign: TextAlign.center)),
      ),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, int index) {
          return ListTile(
            leading: Column(
              children: <Widget>[],
            ),
            title: Text(items[index], style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(items),
            onTap: () {
              if(index == 0) {
                _settingShowAlert(context);
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, index) => Divider(height: 0,),
      )
    );
  }

  //ListTile.divideTiles(
  //            context: context,
  //            tiles: [
  //              ListTile(
  //                leading: Column(
  //                  children: <Widget>[
  //                    Text(''),
  //                  ],
  //                ),
  //                title: Text('You are', style: TextStyle(fontWeight: FontWeight.bold,),),
  //                subtitle: Text('Quit'),
  //                onTap: () {
  //                  _settingShowAlert(context);
  //                },
  //              ),
  //              Information(),
  //            ]
  //        ).toList(),

  void _settingShowAlert(BuildContext settingContext) {
    showDialog(
        context: settingContext,
      builder: (_) => AlertDialog(
        title: Text('Alert'),
        content: Text('Do you want to QUIT?', style: TextStyle(fontSize: 18.0),),
        actions: <Widget>[
          FlatButton(onPressed: () {Navigator.of(settingContext).pop();}, child: Text('Cancel')),
          FlatButton(onPressed: () {Navigator.of(settingContext).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);}, child: Text('Confirm')),
        ],
      )
    );
  }
}

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Column(
            children: <Widget>[
              Text(''),
            ],
          ),
          title: Text('Information', style: TextStyle(fontSize: 12, color: Colors.purple,fontWeight: FontWeight.bold,)),
        ),
        ListTile(
          leading: Column(
            children: <Widget>[
              Text(''),
            ],
          ),
          title: Text('Developer', style: TextStyle(fontWeight: FontWeight.bold,)),
          subtitle: Text('db'),
        ),
        ListTile(
          leading: Column(
            children: <Widget>[
              Text(''),
            ],
          ),
          title: Text('Version', style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text('1.0.0'),
        ),
      ],
    );
  }
}

enum SettingDialogAction{
  yes,
  no,
}
