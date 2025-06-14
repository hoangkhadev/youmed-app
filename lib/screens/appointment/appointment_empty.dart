import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';

class AppointmentEmpty extends StatelessWidget {
  const AppointmentEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(GlobalImageIcons.noAppointmentBanner, width: 150),
          SizedBox(height: 18),
          Text(
            textAlign: TextAlign.center,
            'Bạn chưa có lịch khám',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            textAlign: TextAlign.center,
            'Lịch khám của bạn sẽ được hiển thị tại đây.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
