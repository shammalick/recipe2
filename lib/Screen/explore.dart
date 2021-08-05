import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe2/Utils/constants.dart';
import 'package:recipe2/Widget/category.dart';
import 'package:recipe2/Widget/drawer.dart';
import 'package:recipe2/Widget/popularRecipiesCard.dart';
import 'package:recipe2/Widget/recipiesCard.dart';
import 'package:recipe2/Widget/shared.dart';

class Explore extends StatefulWidget {
  // bool optionSelected = false;
  // Explore({this.optionSelected});
  @override
  _ExploreState createState() => _ExploreState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _ExploreState extends State<Explore> {
  String currentEmail;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map count;
  bool isCount;
  int numberCount;
  Future getCurrentUser() async {
    final User user = await _auth.currentUser;
    final email = user.email;
    print(email);
    return email.toString();
  }

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     widget.optionSelected = false ?? true ;
//   }

  @override
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: blackk),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 16),
        //     child: AnimatedSearchBar(),
        //   ),
        // ],
      ),
      drawer: SideList(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1('I Made it'),
                  buildTextSubTitleVariation1(
                      'Healthy and nutritious food recipes'),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 15.4,
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
                    onTap: () => category(context),
                    child: Center(
                      child: Text("Category",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 350,
              child: RecipiesCard(),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Popular',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: blackk,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Food',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                      )),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  PopularRecipies(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
