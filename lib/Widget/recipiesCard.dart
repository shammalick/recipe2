import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe2/Screen/detail.dart';
import 'package:recipe2/Utils/constants.dart';
import 'package:recipe2/Widget/shared.dart';

class RecipiesCard extends StatefulWidget {
  @override
  _RecipiesCardState createState() => _RecipiesCardState();
}

class _RecipiesCardState extends State<RecipiesCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool check = false;
  var number;

  Future getCurrentUser() async {
    final User user = await _auth.currentUser;
    final email = user.email;
    print(email);
    return email.toString();
  }

  @override
  void initState() {
    super.initState();
    _createRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('recipies').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var itemCount;
            var recipies = snapshot.data.docs;
            if (recipies.length > 11) {
              itemCount = 10;
            } else {
              itemCount = recipies.length;
            }
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  number = recipies[index].get('views');

                  try {
                    if (recipies[index].get('fav.${(_auth.currentUser.uid)}') ==
                        true) {
                      check = true;
                    }
                    if (recipies[index].get('fav.${(_auth.currentUser.uid)}') ==
                        false) {
                      check = false;
                    }
                  } catch (e) {
                    check = false;
                  }

                  return GestureDetector(
                    onTap: () {
                      _showRewardedAd();
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
                                  views: recipies[index].get('views'),
                                  id: recipies[index].get('id'),
                                )),
                      );
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: [kBoxShadow],
                      ),
                      margin: EdgeInsets.only(
                          right: 16,
                          left: index == 0 ? 16 : 0,
                          bottom: 16,
                          top: 8),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Hero(
                              tag: recipies[index].get('imgUrl'),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        recipies[index].get('imgUrl'),
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          buildRecipeTitle(recipies[index].get('title')),
                          buildTextSubTitleVariation2(
                              recipies[index].get('dec')),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildCalories(
                                    recipies[index].get('kcal') + " Kcal"),
                                SizedBox(width: 5),
                                Row(
                                  children: [
                                    numberConvert(number),
                                    // Text('${number}'),
                                    SizedBox(width: 3),
                                    Icon(Icons.remove_red_eye_rounded),
                                  ],
                                ),
                                Expanded(
                                  child: FlatButton(
                                      onPressed: () {
                                        addFavorite(recipies[index].get('id'),
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
                                                .showSnackBar(new SnackBar(
                                              content: new Text(
                                                  '${(recipies[index].get('title'))} is saved'),
                                              backgroundColor:
                                                  Color(0xFF27AE60),
                                              padding: EdgeInsets.all(10.0),
                                              margin: EdgeInsets.all(10.0),
                                              duration:
                                                  const Duration(seconds: 2),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                            ));
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color:
                                            check ? Colors.red : Colors.black,
                                      )),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return LinearProgressIndicator();
          }
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

  RewardedAd _rewardedAd;
  int maxFailedLoadAttempts = 3;
  int _numRewardedLoadAttempts = 0;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: "ca-app-pub-5534506225496412/8633368297",
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }
}
