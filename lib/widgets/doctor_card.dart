import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';
import 'package:my_flutter_app/screens/appointment/appointment_booking.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalColors.whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(doctor.avatarUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.user.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${doctor.experienceYears} năm kinh nghiệm',
                        style: TextStyle(color: GlobalColors.grayColor),
                      ),
                      const SizedBox(height: 6),

                      ScrollableScreenWrapper(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              doctor.specializations.map<Widget>((item) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    doctor.user.address,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppointmentBooking.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Đặt lịch ngay',
                  style: TextStyle(
                    color: GlobalColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
