import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class typingScreen extends StatefulWidget {
  _typingScreenState createState() => _typingScreenState();
}

class _typingScreenState extends State<typingScreen> {
  TextEditingController _controller;
  String test_text =
      '''Last week we installed a kitty door so that our cat could come and go as she pleases. Unfortunately, we ran into a problem. Our cat was afraid to use the kitty door. We tried pushing her through, and that caused her to be even more afraid. The kitty door was dark, and she couldn\'t see what was on the other side. Our cat was afraid to use the kitty door. We tried pushing her through, and that caused her to be even more afraid. ''';
  String written_text;
  List<String> indx = [];
  List<TextSpan> childs = [];
  //int indx;
  void initState() {
    super.initState();
    _controller = TextEditingController();
    childs.add(
      TextSpan(
        text: test_text ?? 'default value',
        style: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String reformatString(String temp) {
    if (temp.length > 3) {
      return temp.substring(temp.length - 3);
    }
    return temp;
  }

  List<TextSpan> _getText(String text) {
    if (text != null) {
      if (text.length > 0) {
        if (text.length <= test_text.length &&
            text[text.length - 1] == test_text[text.length - 1]) {
          indx = [];
          indx.add(test_text.substring(0, text.length));
          indx.add(test_text.substring(text.length, test_text.length));
          if (indx[0] == text) {
            childs = [];
            childs.add(
              TextSpan(
                text: reformatString(indx[0]),
                style: TextStyle(color: Colors.green, fontSize: 22),
              ),
            );
            childs.add(
              TextSpan(
                text: indx[1] ?? 'default value',
                style: TextStyle(color: Colors.red, fontSize: 22),
              ),
            );

            return childs;
          }
          return childs;
        }
      } else {
        childs = [];
        childs.add(
          TextSpan(
            text: test_text ?? 'default value',
            style: TextStyle(color: Colors.red, fontSize: 22),
          ),
        );
        return childs;
      }
    }
    //print(indx);
    return childs;
  }

  //
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4563DB),
        //B141F2
        title: Text('Start Typing'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.4, 0.9],
          colors: [
            Color(0xFFE8DBFC),
            Color(0xFFF8F9D2),
          ],
        )),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(
                10.0,
              ),
              child: Container(
                height: 200,
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(children: _getText(written_text)),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              child: TextField(
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input Field',
                ),
                maxLines: 50,
                controller: _controller,
                onChanged: (String text) async {
                  if (written_text != text) {
                    setState(() {
                      written_text = text;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
