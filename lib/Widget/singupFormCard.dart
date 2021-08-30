import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:recipe2/Screen/login.dart';
import 'package:recipe2/Screen/waitAfterSignup.dart';
import 'package:recipe2/controllers/authController.dart';

class SignUpFormCard extends GetWidget<AuthController> {
  final TextEditingController uidController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          new Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 5, bottom: 20),
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
                  Text("SignUp",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Poppins-Bold",
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6)),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Username",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium", fontSize: 16)),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Text is empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Email",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium", fontSize: 16)),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email@...com",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                    validator: (text) {
                      if (!(text.contains('@')) && text.isNotEmpty) {
                        return "Enter a valid email address!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Password",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium", fontSize: 16)),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                    validator: (text) {
                      if (!(text.length > 5) && text.isNotEmpty) {
                        return "Enter valid name of more then 5 characters!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Confirm Password",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium", fontSize: 16)),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),
                  ),
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
                child: GestureDetector(
                  child: InkWell(
                    onTap: () async {
                      if (!_formKey.currentState.validate()) {
                        await _saveForm();
                      } else {
                        controller.createUser(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          uidController.text,
                        );
                        if (controller != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Waiting()));
                        }
                      }

                
                    },
                    child: Center(
                      child: Text("SIGN UP",
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
          ),
        ],
      ),
    );
  }
}
