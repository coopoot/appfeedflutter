import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/response/response.dart';
import 'package:flutterapp2/utils/constants.dart';
import 'package:flutterapp2/webservice/rest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Minha Página'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var response = new List<Response>();

  _getData() {
    Rest.getData().then((data) {
      setState(() {
        Iterable list = json.decode(data.body);
        response = list.map((model) => Response.fromJson(model)).toList();
      });
    });
  }

  _MyHomePageState() {
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: response.length,
          itemBuilder: listTile,
        ));
  }

  String convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    return (formatDate(
        todayDate, [dd, '/', mm, '/', yyyy, ' ', hh, ':', nn, ':', ss]));
  }

  Column listTile(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Card(
            child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage(response[index].person.profilePhotoUri)),
              title: Text(response[index].person.name,
                  style: TextStyle(fontSize: 18)),
              trailing:
                  Text(this.convertDateFromString(response[index].created)),
            ),
          ],
        )),
        Column(
          children: <Widget>[
            response[index].photoUri == null
                ? Image.asset(Constants.IMAGE_ASSET_URL)
                : Image.network(response[index].photoUri)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  new SizedBox(
                    width: 16.0,
                  ),
                  new Icon(
                    Icons.comment,
                    color: Colors.grey,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  new SizedBox(
                    width: 16.0,
                  ),
                  new Icon(
                    Icons.send,
                    color: Colors.grey,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  )
                ],
              ),
              new Icon(
                Icons.turned_in,
                color: Colors.grey,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              )
            ],
          ),
        ),
        Padding(
          child: Row(
            children: <Widget>[
              Text(response[index].likes.toString() + " Likes")
            ],
          ),
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        ),
        Padding(
          child: Row(
            children: <Widget>[
              Text(response[index].comments.length != 0
                  ? response[index].comments[0].person.name.toString() +
                      " " +
                      response[index].comments[0].text
                  : "")
            ],
          ),
          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
        ),
      ],
    );
  }
}
