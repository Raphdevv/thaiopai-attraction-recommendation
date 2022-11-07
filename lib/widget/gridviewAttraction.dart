import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thiaopai/screen/attractlist_screen.dart';

class GridAttraction extends StatefulWidget {
  const GridAttraction({
    super.key,
    required this.crossAxisCount,
  });

  final int crossAxisCount;

  @override
  State<GridAttraction> createState() => _GridAttractionState();
}

class _GridAttractionState extends State<GridAttraction> {
  final Stream<QuerySnapshot> _AttractionStream =
      FirebaseFirestore.instance.collection('Attraction').snapshots();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
      stream: _AttractionStream,
      builder: (context, snapshot) {
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 350,
                  crossAxisCount: widget.crossAxisCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: ((context, index) {
                dynamic attraction_data = snapshot.data!.docs;
                List<dynamic> img = attraction_data[index]['img'];
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Image.network(
                            img[0],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AttractionScreen(
                                      img: img,
                                      name: attraction_data[index]['name'],
                                      time: attraction_data[index]['time'],
                                      geo: attraction_data[index]['geo'],
                                      description: attraction_data[index]
                                          ['description'],
                                    ),
                                  ),
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
                                  "รายละเอียด",
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
              }),
            ),
          ),
        );
      },
    );
  }
}
