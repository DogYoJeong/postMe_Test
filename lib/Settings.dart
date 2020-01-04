import 'package:flutter/material.dart';

/*class SettingPage extends StatefulWidget {

  //DropDownButton에서 보낸거 받기
  @override
  SettingPageState createState() => SettingPageState();
}*/

class Sub {
  var title ;
  var subtitle;

  Sub({this.title, this.subtitle});

}

class SettingPage extends StatelessWidget {
  List<Sub> items = List();

  SettingPage(){
    items.add(Sub(title: "You are", subtitle: "Quit"));
    items.add(Sub(title: "Developer", subtitle: "db"));
    items.add(Sub(title: "Version", subtitle: "1.0.0"));
  }

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
            title: Text(items[index].title, style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(items[index].subtitle),
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
enum SettingDialogAction{
  yes,
  no,
}
