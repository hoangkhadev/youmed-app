import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import '../../screens/appointment/appointment_booking.dart';
import '../../utils/global.images.icons.dart';
import '../../widgets/schedule_weekdays.dart';
import '../../utils/global.colors.dart';
import 'package:flutter_html/flutter_html.dart';

class DoctorDetail extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetail({super.key, required this.doctor});

  static final id = 'doctor_detail_screen';

  @override
  Widget build(BuildContext context) {
    print(">> check doctor: ${doctor.schedules}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleSpacing: 0,
          title: const Text(
            'Thông tin bác sĩ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              label: const Text(
                'Lưu lại',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {},
            ),
            Container(
              height: 16,
              width: 1,
              color: Colors.black38,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            ),
            TextButton.icon(
              icon: const Icon(Icons.help_outline, color: Colors.white),
              label: const Text(
                'Hỗ trợ',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {},
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(doctor.avatarUrl),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.user.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Bác sĩ',
                            style: TextStyle(color: Colors.blue),
                          ),
                          Text('${doctor.experienceYears} năm kinh nghiệm'),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              doctor.specializations
                                  .map((e) => e.name)
                                  .toList()
                                  .join(', '),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lịch khám",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ScheduleWeekDays(
                            onDateSelected: (date) {
                              // print("Selected date: $date");
                            },
                            schedules: doctor.schedules.toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Text(
                      "Buổi chiều",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 2,
                      children: const [
                        TimeSlotButton(time: "17:30-17:40"),
                        TimeSlotButton(time: "17:40-17:50"),
                        TimeSlotButton(time: "17:50-18:00"),
                        TimeSlotButton(time: "17:50-18:00"),
                        TimeSlotButton(time: "17:50-18:00"),
                        TimeSlotButton(time: "17:50-18:00"),
                      ],
                    ),
                  ],
                ),
              ),

              //const Divider(),

              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 16,
              //     vertical: 12,
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Icon(Icons.location_on, color: Colors.green),
              //       const SizedBox(width: 8),
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(doctorAddress),
              //             TextButton(
              //               onPressed: () {},
              //               child: const Text(
              //                 "Mở bản đồ",
              //                 style: TextStyle(color: Colors.green),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Giới thiệu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Html(data: doctor.bio),
                    const SizedBox(height: 6),
                    if (doctor.position.isNotEmpty) ...[
                      const Text(
                        "Chức vụ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(doctor.position),
                      const SizedBox(height: 6),
                    ],
                    const Text(
                      "Công tác",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(doctor.workplace),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),

        bottomNavigationBar: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 400),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 174, 229, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: GlobalColors.mainColor,
                          width: 2.0,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            GlobalImageIcons.message,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Chat với bác sĩ",
                            style: TextStyle(
                              color: GlobalColors.mainColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Gọi video',
                            style: TextStyle(
                              color: GlobalColors.whiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentBooking(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalColors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Đặt khám",
                            style: TextStyle(
                              color: GlobalColors.whiteColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimeSlotButton extends StatelessWidget {
  final String time;

  const TimeSlotButton({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: GlobalColors.mainColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(time),
    );
  }
}
