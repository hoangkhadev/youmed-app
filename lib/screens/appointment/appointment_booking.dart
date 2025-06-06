import 'package:flutter/material.dart';
import '../../utils/global.colors.dart';
import '../../widgets/schedule_weekdays.dart';

class AppointmentBooking extends StatefulWidget {
  const AppointmentBooking({super.key});

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const Text(
          'Đặt lịch khám',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://via.placeholder.com/150",
                ),
              ),
              title: Text(
                "Vũ Thị Hạnh Thư",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Chuyên khoa: Sản phụ khoa"),
            ),
            const Divider(),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Đặt lịch khám này cho:"),
                  SizedBox(height: 8),
                  Text("Họ và tên: Nguyễn Phú Tài"),
                  Text("Giới tính: Nam"),
                  Text("Ngày sinh: 21/01/2004"),
                  Text("Điện thoại: 0788 655 673"),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: null,
                      child: Text("Sửa hồ sơ"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Chọn ngày khám",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ScheduleWeekDays(
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            print("Ngày đã chọn: $selectedDate");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            "Tiếp tục",
            style: TextStyle(fontSize: 18, color: GlobalColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
