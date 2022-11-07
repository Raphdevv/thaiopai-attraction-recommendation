import 'package:flutter/material.dart';

class BannerRecommender extends StatelessWidget {
  const BannerRecommender({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: const BoxDecoration(
        color: Color(0xff71D3FF),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 192, 192, 192),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            child: Container(
              height: 100,
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 115,
            left: 20,
            child: Text(
              "Recommender",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
