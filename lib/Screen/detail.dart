import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe2/Utils/constants.dart';
import 'package:recipe2/Widget/shared.dart';
import 'package:recipe2/ads_helper.dart';

class Detail extends StatefulWidget {
  final String title;
  final String carb;
  final String dec;
  final String imgUrl;
  final String ingr;
  final String kcal;
  final String method;
  final String protein;
  var views;
  final String id;
  Detail(
      {@required this.title,
      @required this.carb,
      @required this.dec,
      @required this.imgUrl,
      @required this.ingr,
      @required this.kcal,
      @required this.method,
      @required this.protein,
      @required this.views,
      @required this.id});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future getCurrentUser() async {
    final User user = await _auth.currentUser;
    final email = user.email;
    print(email);
    return email.toString();
  }
bool optionSelected = false;
 BannerAd _bannerAd;
 bool _isBannerAdReady = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void initState(){
    super.initState();
  
     _bannerAd = BannerAd(
    adUnitId: AdHelper.bannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (_) {
        setState(() {
          _isBannerAdReady = true;
        });
      },
      onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        _isBannerAdReady = false;
        ad.dispose();
      },
    ),
  );
   

  _bannerAd.load();


    this.widget.views++;
    optionSelected = false ?? true;
     createViews(this.widget.id);
    //  Admob.requestTrackingAuthorization();
   
    print("init");
  }
   @override
  void dispose() {
    super.dispose();
    _anchoredBanner?.dispose();
  
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Builder(builder: (BuildContext context) {
        if (!_loadingAnchoredBanner) {
          _loadingAnchoredBanner = true;
          _createAnchoredBanner(context);
        }
    return Scaffold(
      
      backgroundColor: Colors.grey[50],

        bottomNavigationBar: Row(children: [
          
                if (_anchoredBanner != null)
                  Container(
                    color: Colors.green,
                    width: _anchoredBanner.size.width.toDouble(),
                    height: _anchoredBanner.size.height.toDouble(),
                    child: AdWidget(ad: _anchoredBanner),
                  ),
        ],),
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            createViews(this.widget.id);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
       
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1(this.widget.title),
                  buildTextSubTitleVariation1(this.widget.dec),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                 height:  300,
                padding: EdgeInsets.only(left: 18),
                child: Stack(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
            buildTextTitleVariation2('Nutritions', false),
            SizedBox(
              height: MediaQuery.of(context).size.height / 90,
            ),
            buildNutrition(this.widget.kcal, "Calories", "Kcal"),
            SizedBox(
              height: MediaQuery.of(context).size.height / 90,
            ),
            buildNutrition(this.widget.carb, "Carbo", "g"),
            SizedBox(
              height: MediaQuery.of(context).size.height / 90,
            ),
            buildNutrition(this.widget.protein, "Protein", "g"),
                        ],
                      ),
                    Positioned(
                      left: MediaQuery.of(context).size.height / 4,
                      top: MediaQuery.of(context).size.height / 40,
                      bottom: MediaQuery.of(context).size.height / 100,
                      child: Hero(
                        tag: widget.imgUrl,
                        child: ClipOval(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imgUrl),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation2('Ingredients', false),
                  buildTextSubTitleVariation(this.widget.ingr),
                  SizedBox(
                    height: (16),
                  ),
                  buildTextTitleVariation2('Recipe preparation', false),
                  buildTextSubTitleVariation(this.widget.method),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
      }
      )
      );
  }

  Widget buildNutrition(
    String value,
    String title,
    String subTitle,
  ) {
    return Container(
      height: 65,
      width: 165,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [kBoxShadow],
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> createViews(
    String id,
  ) async {
    try {
      await _firestore
          .collection('recipies')
          .doc(id)
          .update({"views": this.widget.views});

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;

   Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-5534506225496412/3703862866'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }


 
}
