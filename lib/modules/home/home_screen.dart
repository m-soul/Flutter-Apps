import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 100, 100),
        leading: Icon(Icons.menu),
        title: Text('Yo bitch'),
        actions: [
          IconButton(
            icon: Icon(Icons.notification_important),
            onPressed: () {
              print('Notification');
            },
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('Search');
              })
        ],
      ),
      body: Container(
        color: Colors.lightGreenAccent,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              color: Colors.red,
              child: Text(
                'First Text',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
