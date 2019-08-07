import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:postme_test/Settings.dart';
import 'package:postme_test/CreateFile.dart';


Future<List<Post>> fetchPosts(http.Client client) async {
  final response = await client.get("https://jsonplaceholder.typicode.com/posts");

  return parsePosts(response.body);
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
  final posts;

  PostPage({Key key, this.posts}) : super(key: key);

  @override
  PostPageState createState() => PostPageState(MePosts: posts);
}

class PostPageState extends State<PostPage> {
  List<Post> MePosts;

  PostPageState({this.MePosts});

  void initState() {
    super.initState();
    fetchPosts(http.Client()).then((list) {
      setState(() {
        MePosts.addAll(list);
        print(MePosts.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Me'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.library_add),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PlusFile())
                );
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage())
                );
              })
        ],
      ),
      body: ListView.builder(
          itemCount: MePosts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(''),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfo(),
                    )
                );
              },
            );
          }),
    );
  }
}

class UserInfo extends StatelessWidget {
  final List<Post> todo;

  UserInfo({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Center(child: Text('UserInfo', textAlign: TextAlign.center)),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text('1234'),
      ),
    );
  }
}

