import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Com>> fetchPosts(http.Client client) async {
  final response = await client.get("https://jsonplaceholder.typicode.com/comments");

  return compute(parseComs, response.body);
}
List<Com> parseComs(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Com>((json) => Com.fromJson(json)).toList();
}
class Com {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Com({this.postId, this.id, this.name, this.email, this.body});

  factory Com.fromJson(Map<String, dynamic> json) {
    return Com (
      postId: json['postId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}


class Comment extends StatefulWidget {
  @override
  CommentState createState() => CommentState();
}
class CommentState extends State<Comment> {
  final List<Com> comPost = List();

  void initState() {
    super.initState();
    fetchPosts(http.Client()).then((list) {
      setState(() {
        comPost.addAll(list);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Comments', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      Container (
        width: 350,
        height: 450,
        child: ListView.builder(
            itemCount: comPost.length,
            itemBuilder: (context, int index) {
              return ListTile(
                leading: Column(
                  children: <Widget>[
                    Text('User'+comPost[index].id.toString()),
                  ],
                ),
                title: Text(comPost[index].name, style: TextStyle(fontSize: 15 ),),
                subtitle: Text(comPost[index].body),
              );
            }),
      ),
      ],
    );
  }
}

