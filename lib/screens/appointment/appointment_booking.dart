import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/custom_bottom_sheet.dart';
import 'package:my_flutter_app/widgets/schedule_weekdays.dart';
import 'package:my_flutter_app/widgets/time_slot.dart';

class AppointmentBooking extends StatefulWidget {
  const AppointmentBooking({super.key});
  static final id = 'appointmentbooking';

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime selectedDate = DateTime.now();

  List<String> timeSlotsMorning = [
    '07:30-07:40',
    '07:40-07:50',
    '08:00-08:10',
    '08:10-08:20',
    '08:20-08:30',
  ];

  List<String> timeSlotsAfternoon = [
    '13:30-13:40',
    '13:40-13:50',
    '14:00-14:10',
    '14:10-14:20',
    '14:20-14:30',
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {
        selectedIndex = _tabController.index == 0 ? 0 : timeSlotsMorning.length;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
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
        backgroundColor: GlobalColors.bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor info
                Container(
                  decoration: BoxDecoration(
                    color: GlobalColors.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://via.placeholder.com/150",
                      ),
                    ),
                    title: const Text(
                      "Vũ Thị Hạnh Thư",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Chuyên khoa: Sản phụ khoa"),
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Đặt lịch khám này cho:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Patient info
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: GlobalColors.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Họ và tên: Nguyễn Phú Tài"),
                            Text("Giới tính: Nam"),
                            Text("Ngày sinh: 21/01/2004"),
                            Text("Điện thoại: 0788 655 673"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                              ),
                              child: const Text(
                                "Xem chi tiết",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: GlobalColors.mainColor,
                                backgroundColor: Colors.grey.shade100,
                              ),
                              child: const Text(
                                "Sửa hồ sơ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
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

                Container(
                  decoration: BoxDecoration(
                    color: GlobalColors.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ScheduleWeekDays(
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                const Text(
                  "Chọn khung giờ khám",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: GlobalColors.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.blue,
                        tabs: const [
                          Tab(text: 'Buổi sáng'),
                          Tab(text: 'Buổi chiều'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 180,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Center(
                              child: Wrap(
                                runSpacing: 12,
                                children: List.generate(
                                  timeSlotsMorning.length,
                                  (index) {
                                    return TimeSlot(
                                      time: timeSlotsMorning[index],
                                      isSelected: selectedIndex == index,
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Center(
                              child: Wrap(
                                runSpacing: 12,
                                children: List.generate(
                                  timeSlotsAfternoon.length,
                                  (index) {
                                    int actualIndex =
                                        index + timeSlotsMorning.length;
                                    return TimeSlot(
                                      time: timeSlotsAfternoon[index],
                                      isSelected: selectedIndex == actualIndex,
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = actualIndex;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          color: GlobalColors.whiteColor,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Tiếp tục',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.whiteColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
