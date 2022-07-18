import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((e) {
          return Builder(
              builder: (BuildContext context) =>
                  Image.network(e, fit: BoxFit.cover, height: 60));
        }).toList(),
        options: CarouselOptions(viewportFraction: 1, height: 200));
  }
}
