import 'package:flutter/material.dart';
import 'package:postme_test/PostMe.dart';

enum EditDialogueAction{
  yes,
  no,
}

class Edit extends StatefulWidget {
  Edit({this.editData});
  final Post editData;
  @override
  EditState createState() => EditState(editData: editData);
}
class EditState extends State<Edit> {
  final _editTitleKey = GlobalKey<FormState>();
  final Post editData;

  EditState({this.editData});
 // final GlobalKey<ScaffoldState> _editKey = GlobalKey<ScaffoldState>();
  final _editTitleController = TextEditingController(text: '');
  final _editBodyController = TextEditingController(text: '');

  String _changeText = '';

  @override
  void initState() {
    super.initState();
    _editBodyController.addListener(() {
    });
    _editTitleController.addListener(() {
    });
  }

  void dispose() {
    _editTitleController.dispose();
    _editBodyController.dispose();
    super.dispose();
  }
  /*_openDetailChange(BuildContext context, tempData) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(index: tempData)),
    );
    print(result.toString());
    if (result != null) {
    }
  }
  */

  void _changeDialogResult(EditDialogueAction value){
    Navigator.of(context).pop();
  }
  void _changeShowAlert (String value) {
    showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
          title:  Text('Alert'),
          content:  Text('Are you sure to Change this post?',
            style:  TextStyle(fontSize: 18.0),),
          actions: <Widget>[
            FlatButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
            FlatButton(onPressed: () {_changeDialogResult(EditDialogueAction.yes);}, child: Text('Confirm')),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Edit'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),
              onPressed: () {
                if (_editTitleKey.currentState.validate()) {
                  _changeShowAlert(_changeText);
                }
              })
        ],
      ),
      body: Form(
        key: _editTitleKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('title',style: TextStyle(fontSize: 20, color: Colors.purple),),
            TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: _editTitleController ,
              maxLength: 150,
            ),
            Text('body', style: TextStyle(fontSize: 18, color: Colors.purple),),
            TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                maxLength: 500,
                controller: _editBodyController ,
            ),
          ],
        ),
      ),
    );
  }
}