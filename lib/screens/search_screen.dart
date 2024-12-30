import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('itunes app')),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: InputDecoration(
                labelText: 'Search for songs',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search)),
          ),
        ));
  }
}
