import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {


   final List<String> _imageList = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        height: MediaQuery.of(context).size.width > 600 ? 400 : 200,
        viewportFraction: 1,
      ),
      items: _imageList.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
