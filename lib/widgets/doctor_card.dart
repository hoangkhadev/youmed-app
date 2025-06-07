import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/appointment/appointment_booking.dart';
import 'package:my_flutter_app/screens/search/search_doctordetail.dart';
import '../../models/doctor.model.dart';
import '../../utils/global.colors.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onBookingPressed;

  const DoctorCard({Key? key, required this.doctor, this.onBookingPressed})
    : super(key: key);

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
                  backgroundImage: AssetImage(doctor.avatarUrl),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${doctor.title} ${doctor.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${doctor.experience} năm kinh nghiệm',
                        style: TextStyle(color: GlobalColors.grayColor),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          doctor.specialty,
                          style: const TextStyle(fontSize: 13),
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
                    doctor.address,
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
                  style: TextStyle(color: GlobalColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
