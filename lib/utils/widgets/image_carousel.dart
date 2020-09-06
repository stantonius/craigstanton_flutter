import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/NZ.jpg',
  'assets/images/Cambodia.jpg',
  'assets/images/NZ2.jpg',
  'assets/images/Scotland.jpg'
];

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            height: 400.0,
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 2),
            viewportFraction: 1.0),
        items: imgList.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  child: Center(child: Image.network(item, fit: BoxFit.cover)));
            },
          );
        }).toList(),
      ),
    );
  }
}
