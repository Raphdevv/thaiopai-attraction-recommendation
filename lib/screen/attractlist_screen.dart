import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thiaopai/model/get_samilar_models.dart';
import 'package:thiaopai/widget/carousel_slider.dart';

class AttractionScreen extends StatefulWidget {
  const AttractionScreen({
    super.key,
    required this.img,
    required this.name,
    required this.time,
    required this.description,
    required this.geo,
  });

  final List<dynamic> img;
  final String name;
  final String time;
  final String description;
  final List<dynamic> geo;

  @override
  State<AttractionScreen> createState() => _AttractionScreenState();
}

class _AttractionScreenState extends State<AttractionScreen> {
  final Map<String, dynamic> attraction_Of_User = HashMap();
  late GetSamilar getSamilar;
  late final PageController pageController;
  late Completer<GoogleMapController> _controller;
  double rating = 0.0;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('Users');

  @override
  void initState() {
    getSamilar = GetSamilar(data: [], samilar: {}, recommend: []);
    pageController = PageController();
    _controller = Completer();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff71D3FF),
          ),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(
            color: Color(0xff71D3FF),
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              pageController: pageController,
              img: widget.img,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.time,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(widget.description),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () => showRating(),
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xff71D3FF),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(2, 2),
                            ),
                          ]),
                      child: const Text(
                        'ให้คะแนน',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            )
          ],
        ),
      ),
    );
  }

  void showRating() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ให้คะแนนสถานที่ท่องเที่ยวของคุณ'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ให้คะแนน ${widget.name} สำหรับคุณ',
                style: const TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(child: buildRating()),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (rating > 3.0) {
                  await getSamilar.loadAssets();
                  await getSamilar.get_samilar(widget.name, rating);
                  await getSamilar.get_attraction(getSamilar.samilar);
                  String userID = firebaseAuth.currentUser!.uid;
                  DocumentReference documentReference =
                      _userReference.doc(userID);
                  if (getSamilar.recommend.length > 2) {
                    attraction_Of_User.addAll({
                      'recommender': FieldValue.arrayUnion(
                          getSamilar.recommend.sublist(0, 3))
                    });

                    getSamilar.recommend.clear();
                  } else {
                    attraction_Of_User.addAll({
                      'recommender': FieldValue.arrayUnion(getSamilar.recommend)
                    });
                    getSamilar.recommend.clear();
                  }

                  documentReference
                      .update(attraction_Of_User)
                      .then((value) => Navigator.of(context).pop());
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('ให้คะแนน'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('ยกเลิก'),
            )
          ],
        ),
      );

  Widget buildRating() => RatingBar.builder(
        minRating: 1,
        itemSize: 30,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (value) => setState(
          () {
            rating = value;
          },
        ),
      );
}
