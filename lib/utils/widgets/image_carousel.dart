import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'images/NZ.jpg',
  'images/Cambodia.jpg',
  'images/NZ2.jpg',
  'images/Scotland.jpg'
];

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 2),
            viewportFraction: 1.0),
        items: imgList.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  child: Center(child: Image.asset(item, fit: BoxFit.fill)));
            },
          );
        }).toList(),
      ),
    );
  }
}
