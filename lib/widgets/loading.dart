import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: GlobalColors.mainColor),
    );
  }
}
