import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_flutter_app/screens/home/home_header.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';

final List<String> imgList = [
  GlobalImageIcons.banner1,
  GlobalImageIcons.banner2,
  GlobalImageIcons.banner3,
  GlobalImageIcons.banner4,
  GlobalImageIcons.banner5,
];

class HomeBannerScreen extends StatelessWidget {
  const HomeBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = 180;
    return Column(
      children: [
        HomeHeader(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
      ],
    );
  }
}
