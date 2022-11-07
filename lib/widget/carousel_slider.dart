import 'package:flutter/material.dart';

class CarouselSlider extends StatelessWidget {
  const CarouselSlider({
    super.key,
    required this.pageController,
    required this.img,
  });

  final PageController pageController;
  final List<dynamic> img;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: pageController,
        itemBuilder: ((context, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: ((context, child) => child!),
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  img[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
        itemCount: img.length,
      ),
    );
  }
}
