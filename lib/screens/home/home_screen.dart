import 'package:flutter/material.dart';

import '../../screens/home/home_banner.dart';
import '../../screens/home/home_clinic.dart';
import '../../screens/home/home_doctor.dart';
import '../../screens/home/home_feature.dart';
import '../../screens/home/home_header.dart';
import '../../screens/home/home_hospital.dart';
import '../../screens/home/home_register_as_member.dart';
import '../../screens/home/home_specialty.dart';
import '../../utils/global.colors.dart';
import '../../widgets/scrollable_screen_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static final id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: HomeHeader(),
        backgroundColor: GlobalColors.mainColor,
        toolbarHeight: 115,
      ),
      body: ScrollableScreenWrapper(
        child: Column(
          children: [
            HomeBanner(),
            HomeFeature(),
            HomeRegisterAsMember(),
            HomeDoctor(),
            HomeHospital(),
            HomeClinic(),
            HomeSpecialty(),
          ],
        ),
      ),
    );
  }
}
