import 'package:flutter/material.dart';
import 'package:postme_test/PostMe.dart';

enum MyDialogueAction{
  yes,
  no,
}

class PlusFile extends StatefulWidget {
  PlusFile({Key key}) : super(key: key);
  @override
  PlusFileState createState() => PlusFileState();
}

class PlusFileState extends State<PlusFile> {
  final _titleKey = GlobalKey<FormState>();

  final _titlecontroller = TextEditingController();
  final _bodycontroller = TextEditingController();
  var addPost;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _bodycontroller.addListener(() {
    });
    _titlecontroller.addListener(() {
    });
  }

  void dispose() {
    _titlecontroller.dispose();
    _bodycontroller.dispose();
    super.dispose();
  }

  void _dialogueResult(MyDialogueAction value){
    Navigator.of(context).pop();
    addPost = Post(userId: 1, id: 1, title: _titlecontroller.text, body: _bodycontroller.text);
    Navigator.pop(context, addPost);
  }

  void _showAlert(String value){
    showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
          title:  Text('Alert'),
          content:  Text('Are you sure to Save this post?',
            style:  TextStyle(fontSize: 19.0),),
          actions: <Widget>[
             FlatButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
             FlatButton(onPressed: () {_dialogueResult(MyDialogueAction.yes);}, child: Text('Confirm')),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('PlusFile'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_titleKey.currentState.validate()) {
                  _showAlert(_text);
                }
              }),
        ],
      ),
      body: Form(
        key: _titleKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('title',style: TextStyle(fontSize: 20, color: Colors.purple),),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter title',border: OutlineInputBorder()),
              controller: _titlecontroller,
              maxLength: 150,
              validator: (titleValue) {
                if (titleValue.isEmpty) {
                  return 'Title Please enter Text';
                }
                return null;
              },
            ),
            Text('body', style: TextStyle(fontSize: 18, color: Colors.purple),),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter body', border: OutlineInputBorder()),
              maxLength: 500,
              controller: _bodycontroller,
              validator: (bodyValue) {
                if (bodyValue.isEmpty) {
                  return 'Title Please enter Text';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}