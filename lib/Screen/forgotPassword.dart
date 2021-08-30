import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String  email;
 final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [],
      ),
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                new Container(
                  width: double.infinity,

                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, -10.0),
                            blurRadius: 10.0),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Forgot Password",
                            style: TextStyle(
                                fontSize: 45,
                                fontFamily: "Poppins-Bold",
                                letterSpacing: .6)),
                        SizedBox(
                          height: 30,
                        ),
                       
                        SizedBox(
                          height: 30,
                        ),
                        Text("Email",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium", fontSize: 26)),
                        TextFormField(
                         
                          decoration: InputDecoration(
                              hintText: "Email@...com",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12.0)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please a Enter';
                            }
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please a valid Email';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                               email = value.trim();
                            });
                          
                          },
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  child: Container(
                    width: 230,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Color(0xFF27AE60),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF6078ea).withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
 auth.sendPasswordResetEmail(email: email);
                    Navigator.of(context).pop();

                          if (_formkey.currentState.validate()) {
                            print("successful");
                          } else {
                            print("UnSuccessfull");
                          }
                        },
                        child: Center(
                          child: Text("Reset Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 18,
                                  letterSpacing: 1.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
