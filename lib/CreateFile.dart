import 'package:flutter/material.dart';

class PlusFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('PlusFile'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: null)
        ],
      ),
    );
  }
}
