import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GridviewRecommender extends StatefulWidget {
  const GridviewRecommender({super.key});

  @override
  State<GridviewRecommender> createState() => _GridviewRecommenderState();
}

class _GridviewRecommenderState extends State<GridviewRecommender> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  late Completer<GoogleMapController> _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = Completer();
  }

  @override
  Widget build(BuildContext context) {
    String userID = firebaseAuth.currentUser!.uid;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(userID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          List<dynamic>? name = data['recommender'];
          if (name == null) {
            return const Center(
              child: Text(
                'ยังไม่มีสถานที่แนะนำสำหรับคุณ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 30,
                ),
              ),
            );
          } else {
            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Attraction')
                  .where('name', whereIn: name)
                  .snapshots(),
              builder: (context, snapshot) {
                dynamic attraction_data = snapshot.data?.docs;
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 350,
                              crossAxisCount: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        List<dynamic> img = attraction_data[index]['img'];
                        List<dynamic> geo = attraction_data[index]['geo'];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Image.network(
                                    img[0],
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      attraction_data[index]['name'],
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      attraction_data[index]['time'],
                                      style: const TextStyle(
                                        color: Colors.black38,
                                        fontSize: 12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final CameraPosition _kGooglePlex =
                                            CameraPosition(
                                          target: LatLng(double.parse(geo[0]),
                                              double.parse(geo[1])),
                                          zoom: 12,
                                        );
                                        final Marker _kGooglePlexMarker =
                                            Marker(
                                          markerId:
                                              const MarkerId('_kGooglePlex'),
                                          infoWindow: InfoWindow(
                                              title: attraction_data[index]
                                                  ['name']),
                                          icon: BitmapDescriptor.defaultMarker,
                                          position: LatLng(double.parse(geo[0]),
                                              double.parse(geo[1])),
                                        );
                                        await showModalBottomSheet(
                                          context: context,
                                          builder: ((context) => Scaffold(
                                                extendBodyBehindAppBar: true,
                                                appBar: AppBar(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                body: GoogleMap(
                                                  mapType: MapType.normal,
                                                  markers: {_kGooglePlexMarker},
                                                  initialCameraPosition:
                                                      _kGooglePlex,
                                                  onMapCreated: (controller) {
                                                    _controller
                                                        .complete(controller);
                                                  },
                                                ),
                                              )),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff71D3FF),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: const Text(
                                          "ตำแหน่งที่ตั้งสถานที่แห่งนี้",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // return Flexible(
    //   child: GridView.builder(
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         mainAxisExtent: 350,
    //         crossAxisCount: 1,
    //         crossAxisSpacing: 8,
    //         mainAxisSpacing: 8),
    //     itemBuilder: ((context, index) {
    //       return Scaffold();
    //     }),
    //   ),
    // );
  }
}
