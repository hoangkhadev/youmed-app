import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/home/home_banner.dart';
import 'package:my_flutter_app/screens/home/home_doctor.dart';
import 'package:my_flutter_app/screens/home/home_feature.dart';
import 'package:my_flutter_app/screens/home/home_specialty.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeBannerScreen(),
        HomeFeatureScrenn(),
        HomeDoctorScreen(),
        HomeSpecialty(),
      ],
    );
  }
}
