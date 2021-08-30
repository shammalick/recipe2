import 'package:flutter/material.dart';

about(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.all(15.0),
          content: Container(
            width: 300.0,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/images/logo.png',height: (320),),
                  SizedBox(height: (40)),
                  Text("Staying current is key in our fast-paced world.\n",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: (5),),
                  Text(
                      "Most people wouldn’t even consider getting a physical morning newspaper anymore, \n"),
                  SizedBox(height: (5),),
                  Text(
                      "so we depend on digital sources for our news. Finding an app that helps you get the news you want in a timely manner is essential.\n"),
                  SizedBox(height:(5)),
                  Text(
                      "Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others.\n"),
                  SizedBox(height: (5),),
                  Text(
                      'Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others.\n'),
                  SizedBox(height: (5),),
                  Text(
                      "Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others. This app is also develop the second version by Ahtasham Haider (ahtasham6266401@gmail.com)\n"),
                  SizedBox(height: (5),),
                  Text(
                      "Now all are in your handy. The app contains so many popular categories of news. Such as news, business, magazines, sports, jobs, technology and entertainment. You can read, bookmark, and share the news with others.\n"),
                 // ignore: deprecated_member_use
                 FlatButton( onPressed: () {
                    Navigator.pop(context);
                  },  
                      child: Text("Close",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
        );
      });
}
