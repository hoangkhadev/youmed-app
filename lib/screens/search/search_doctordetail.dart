import 'package:flutter/material.dart';
import 'package:my_flutter_app/widgets/time_slot.dart';
import '../../screens/appointment/appointment_booking.dart';
import '../../utils/global.images.icons.dart';
import '../../widgets/schedule_weekdays.dart';
import '../../utils/global.colors.dart';

class DoctorDetail extends StatefulWidget {
  const DoctorDetail({super.key});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  int selectedIndex = 0;
  final List<String> timeSlots = [
    "17:30-17:40",
    "17:40-17:50",
    "17:50-18:00",
    "18:00-18:10",
    "18:10-18:20",
    "18:20-18:30",
  ];
  @override
  Widget build(BuildContext context) {
    const doctorName = "Nguyễn Văn A";
    const doctorExperience = 10;
    const doctorSpecialty = "Nội khoa";
    const doctorAddress = "123 Đường Lê Lợi, Quận 1, TP.HCM";
    const doctorDescription =
        "Bác sĩ chuyên khám và điều trị các bệnh nội khoa.";
    const doctorEducation = "Đại học Y Dược TP.HCM";
    const doctorExperienceDetails =
        "10 năm công tác tại Bệnh viện Đại học Y Dược TP.HCM";
    const doctorImageUrl = "https://example.com/doctor_avatar.png";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: GlobalColors.whiteColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleSpacing: 0,
          title: Text(
            'Thông tin bác sĩ',
            style: TextStyle(
              color: GlobalColors.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton.icon(
              icon: Icon(Icons.favorite_border, color: GlobalColors.whiteColor),
              label: Text(
                'Lưu lại',
                style: TextStyle(color: GlobalColors.whiteColor, fontSize: 14),
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
              icon: Icon(Icons.help_outline, color: GlobalColors.whiteColor),
              label: Text(
                'Hỗ trợ',
                style: TextStyle(color: GlobalColors.whiteColor, fontSize: 14),
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundImage: NetworkImage(doctorImageUrl),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctorName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset(
                                        GlobalImageIcons.certification,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Bác sĩ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: GlobalColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text('$doctorExperience năm kinh nghiệm'),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Chuyên khoa: ', style: TextStyle(fontSize: 14)),
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
                            doctorSpecialty,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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
                              print("Selected date: $date");
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Text(
                      "Buổi chiều",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(timeSlots.length, (index) {
                          return TimeSlot(
                            time: timeSlots[index],
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          );
                        }),
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
                      "Giới thiệu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(doctorDescription),
                    const SizedBox(height: 12),
                    const Text(
                      "Quá trình học vấn",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(doctorEducation),
                    const SizedBox(height: 12),
                    const Text(
                      "Quá trình công tác",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(doctorExperienceDetails),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),

        bottomNavigationBar: SizedBox(
          child: Container(
            padding: const EdgeInsets.all(12),
            color: GlobalColors.whiteColor,
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
                              fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
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
                            Navigator.pushNamed(context, AppointmentBooking.id);
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
                              fontWeight: FontWeight.bold,
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
