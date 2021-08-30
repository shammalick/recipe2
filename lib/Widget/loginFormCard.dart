import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:recipe2/Screen/forgotPassword.dart';
import 'package:recipe2/controllers/authController.dart';
class LoginFormCard extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
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
                  Text("Login",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: "Poppins-Bold",
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6)),
                  SizedBox(
                    height: 30,
                  ),
                  Text("Email",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium", fontSize: 19)),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email@...com",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                 
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Password",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium", fontSize: 19)),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
          
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()));
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Poppins-Medium",
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            child: Container(
              width: 130,
              height: 50,
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
                    controller.login(
                        emailController.text, passwordController.text);
                    if (_formkey.currentState.validate()) {
                      print("successful");
                    } else {
                      print("UnSuccessfull");
                    }
                  },
                  child: Center(
                    child: Text("SIGNIN",
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
    );
  }
}
