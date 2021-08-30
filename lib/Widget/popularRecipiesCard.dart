import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe2/Screen/detail.dart';
import 'package:recipe2/Utils/constants.dart';
import 'package:recipe2/Widget/shared.dart';

class PopularRecipies extends StatefulWidget {
  @override
  _PopularRecipiesState createState() => _PopularRecipiesState();
}

class _PopularRecipiesState extends State<PopularRecipies> {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future getCurrentUser() async {
    
    final User user = await _auth.currentUser;
    final email = user.email;
    print(email);
    return email.toString();
    
  }
 
  bool check=false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('recipies').where("views",isGreaterThan:500).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var itemCount;
            var recipies = snapshot.data.docs;
            if(recipies.length>20){
               itemCount=20;
            }
            else{
               itemCount=recipies.length;
            }
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                
                itemCount: itemCount,
                
                itemBuilder: (context, index) {
                  var number = recipies[index].get('views');
                   try {
                    if (recipies[index]
                            .get('fav.${(_auth.currentUser.uid)}') ==
                        true) {
                      check = true;
                    }
                    if (recipies[index]
                            .get('fav.${(_auth.currentUser.uid)}') ==
                        false) {
                      check = false;
                    }
                  } catch (e) {
                    check = false;
                  }
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detail(
                                    title: recipies[index].get('title'),
                                    dec: recipies[index].get('dec'),
                                    carb: recipies[index].get('carb'),
                                    imgUrl: recipies[index].get('imgUrl'),
                                    ingr: recipies[index].get('ingr'),
                                    kcal: recipies[index].get('kcal'),
                                    method: recipies[index].get('method'),
                                    protein: recipies[index].get('protein'),
                                    id: recipies[index].get('id'),
                                    views: recipies[index].get('views'),
                                  )),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [kBoxShadow],
                          ),
                          child: Row(children: <Widget>[
                            Container(
                              height: 160,
                              width: 150,
                              child: Image.network(
                                recipies[index].get('imgUrl'),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildRecipeTitle(
                                        recipies[index].get('title')),
                                    buildRecipeSubTitle(
                                        recipies[index].get('dec')),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        buildCalories(
                                            recipies[index].get('kcal') +
                                                " Kcal"),
                                                 SizedBox(width: 10),
                                        Row(
                                          children: [
                                            numberConvert(number),
                                            // Text('${number}'),
                                            SizedBox(width: 10),
                                            Icon(Icons.remove_red_eye_rounded),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                        
                                        Expanded(
                                          child: FlatButton(
                                              onPressed: () {
                                                addFavorite(
                                                    recipies[index].get('id'),
                                                    _auth.currentUser.uid);
                                                setState(() {
                                                  if (recipies[index].get(
                                                          'fav.${(_auth.currentUser.uid)}') ==
                                                      true) {
                                                    removeFavorite(
                                                recipies[index].get('id'),
                                                _auth.currentUser.uid);
                                                  }
                                                  if (recipies[index].get(
                                                          'fav.${(_auth.currentUser.uid)}') ==
                                                      false) {
                                                    Scaffold.of(context)
                                                        .showSnackBar(
                                                            new SnackBar(
                                                      content: new Text(
                                                          '${(recipies[index].get('title'))} is saved'),
                                                      backgroundColor:
                                                          Color(0xFF27AE60),
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      margin:
                                                          EdgeInsets.all(10.0),
                                                      duration: const Duration(
                                                          seconds: 2),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                    ));
                                                  }

                                                    });
                                              },
                                              child: Icon(Icons.favorite,color: check?Colors.red:Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ])));
                });
          }
          return null;
        });
        
  }

  Future<bool> addFavorite(String id, String email) async {
    try {
      await _firestore.collection('recipies').doc(id)
          // .collection(id)
          .update({"fav.${(email)}": true});
      // .delete();
      // .set({"status":false});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  Future<bool> removeFavorite(
    String id,
    String email,
  ) async {
    try {
      await _firestore.collection('recipies').doc(id)
          // .collection(id)
          .update({"fav.${(email)}": false});
      // .delete();
      // .set({"status":false});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
