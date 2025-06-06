import 'package:flutter/material.dart';

import './home_banner.dart';
import './home_feature.dart';
import './home_specialty.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [HomeBanner(), HomeFeature(), HomeSpecialty()]);
  }
}
