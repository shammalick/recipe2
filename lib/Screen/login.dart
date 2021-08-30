import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe2/Widget/SocialIcons.dart';
import 'package:recipe2/Widget/loginFormCard.dart';
import 'explore.dart';

 class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
              ),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 120,
          height: 1.0,
          color: Colors.black26.withOpacity(0.4),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/images/foods.png"),
              ),
              // Expanded(child: Container()),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 120.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  LoginFormCard(),
                  SizedBox(height: 20),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Social Login",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Poppins-Medium",
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  horizontalLine(),
                  SizedBox(
                    height: 20,
                  ),
                  Socialicon(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text("SignUp",
                            style: TextStyle(
                                color: Color(0xFF27AE60),
                                fontFamily: "Poppins-Bold",
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                     skipUser();
                     
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Explore()));
                    },
                    child: Text("Skip",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF27AE60),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins-Bold")),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> skipUser( ) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
                      final user = await _auth.signInAnonymously();
                      print("object="+ _auth.currentUser.uid);
    try {
      await _firestore.collection('users').doc(_auth.currentUser.uid).set(
        {

"imageUrl":null,
"id":_auth.currentUser.uid

        }
      );
    
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
