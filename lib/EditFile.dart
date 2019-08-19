import 'package:flutter/material.dart';
import 'package:postme_test/PostMe.dart';

enum MyDialogueAction{
  yes,
  no,
}

class PlusFile extends StatefulWidget {
  final Post dPost;
  final int pageCase;
  PlusFile({this.pageCase, this.dPost});

  @override
  PlusFileState createState() => PlusFileState(pageCase: pageCase, dPost: dPost);
}
class PlusFileState extends State<PlusFile> {
  //TODO 생성,삭제 완료 , 숙제 : 수정, DropDownButton, Settings 만들기
  final _titleKey = GlobalKey<FormState>();
  final Post dPost;
  final int pageCase;

  PlusFileState({this.pageCase, this.dPost});

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  var addPost;

  String _text = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      if(pageCase == 2) {
        _titleController.text = dPost.title;
        _bodyController.text = dPost.body;
      }
    });
    _bodyController.addListener(() {

    });
    _titleController.addListener(() {
    });
  }

  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _dialogueResult(MyDialogueAction value){
    Navigator.of(context).pop();
    addPost = Post(userId: 1, id: 1, title: _titleController.text, body: _bodyController.text);
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
        title: pageCase == 1 ? Text('PlusFile') : Text('FixFile'),
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
              controller: _titleController,
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
              controller: _bodyController,
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