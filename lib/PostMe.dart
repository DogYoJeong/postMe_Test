import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:postme_test/Settings.dart';
import 'package:postme_test/EditFile.dart';
import 'package:postme_test/Comments.dart';


Future<List<Post>> fetchPosts(http.Client client) async {
  final response = await client.get("https://jsonplaceholder.typicode.com/posts");

  return compute(parsePosts, response.body);
}
List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post (
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}


class PostPage extends StatefulWidget {
  @override
  PostPageState createState() => PostPageState();
}
class PostPageState extends State<PostPage> {
  List<Post> mePosts; //List()로 초기화!

  void initState() {
    super.initState();
    mePosts = List();
    print('PostMePage');
    fetchPosts(http.Client()).then((list) {
      setState(() {
        mePosts.addAll(list);
        print(mePosts.length);
      });
    });
  }

  _openDetail(BuildContext context, index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(post: mePosts[index],)),
    );
    print("after open Detail : "+result.toString());
    if (result != null) {
      mePosts.removeAt(index);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('it was deleted'),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                mePosts.insert(index, result);
                _scaffoldKey.currentState.hideCurrentSnackBar();
              });
            }),
      ),
      );
    }
    else if(result == null) {
      print("result is null");
    }
}
  _openPlusFile(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlusFile(pageCase: 1)),
    );
    print(result);
    if (result != null) {
      mePosts.insert(0, result) ;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext postPageContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Post Me'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.library_add),
              onPressed: () {
                _openPlusFile(postPageContext);
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(postPageContext, MaterialPageRoute(builder: (context) => SettingPage())
                );
              }),
        ],
      ),
      body: ListView.builder(
          itemCount: mePosts.length,//mePosts?.length ?? 0, 이것을 안써도 되는 이유 : 47번 줄에 {final List<Post> mePosts = List();}이걸로 이미 초기화 했으므로 null이 나올 수 없는데 굳이 null를 테스트 할 필요 없어서
          itemBuilder: (context, int index) {
            return ListTile(
              leading: Column(
                children: <Widget>[
                  Text('User'+mePosts[index].userId.toString()),
                ],
              ),
              title: Text(mePosts[index].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text(mePosts[index].body),
              onTap: () {
                _openDetail(context, index);
              },
            );
          }),
    );
  }
}

class Detail extends StatefulWidget {
  final Post post;

  Detail({this.post});

  @override
  DetailState createState() => DetailState(dPost: post);
}
class DetailState extends State<Detail> {
  final Post dPost;

  DetailState({this.dPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Center(
            child: Text('Detail', textAlign: TextAlign.center)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                if (_detailShowAlert != null) {
                  _detailShowAlert(context);
                }
              }),
          IconButton(
              icon: Icon(Icons.create),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlusFile(pageCase: 2, dPost: dPost)));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: Column(
                children: <Widget>[
                  Text('User'+dPost.userId.toString()),
                ],
              ),
              title: Text(dPost.title),
              subtitle: Text(dPost.body),
            ),
           Comment()
           //여기에 다른 클래스에서 만든걸 그냥 불러오기
          ],
        ),
      ),
    );
  }


  void _detailDialog(DialogAction value, BuildContext scaffoldContext) {
    Navigator.of(context).pop();
    Navigator.pop(scaffoldContext, dPost);
  }
  void _detailShowAlert(BuildContext scaffoldContext) {
    showDialog(
        context: context,
        builder: (_) =>  AlertDialog(
          title:  Text('Alert'),
          content:  Text('Are you sure to Delete this post?', style:  TextStyle(fontSize: 19.0),),
          actions: <Widget>[
            FlatButton(onPressed: () {Navigator.of(context).pop();}, child: Text('Cancel')),
            FlatButton(onPressed: () {_detailDialog(DialogAction.yes, scaffoldContext);}, child: Text('Confirm')),
          ],
        )
    );
  }
}
enum DialogAction {
  yes,
  no,
}