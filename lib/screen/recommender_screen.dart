import 'package:flutter/material.dart';
import 'package:thiaopai/model/get_samilar_models.dart';
import 'package:thiaopai/widget/gridviewRecommender.dart';

class RecommenderScreen extends StatefulWidget {
  const RecommenderScreen({super.key});

  @override
  State<RecommenderScreen> createState() => _RecommenderScreenState();
}

class _RecommenderScreenState extends State<RecommenderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'สถานที่ท่องเที่ยว',
          style: TextStyle(
            color: Color(0xff71D3FF),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            decoration: const BoxDecoration(
              color: Color(0xff71D3FF),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'แนะนำสำหรับคุณ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GridviewRecommender(),
        ],
      ),
    );
  }
}
