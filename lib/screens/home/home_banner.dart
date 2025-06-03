import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/gobal.images.icons.dart';

final List<String> imgList = [
  GlobalImageIcons.banner1,
  GlobalImageIcons.banner2,
  GlobalImageIcons.banner3,
  GlobalImageIcons.banner4,
  GlobalImageIcons.banner5,
];

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = 180;
    return Padding(
      padding: EdgeInsets.only(top: 6, left: 6, right: 6),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items:
                imgList
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity,
                        height: height,
                        child: Image.asset(item, fit: BoxFit.cover),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
