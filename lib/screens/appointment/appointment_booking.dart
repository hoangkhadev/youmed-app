import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
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
    '15:20-15:30',
    '13:30-13:40',
    '13:40-13:50',
    '14:00-14:10',
    '14:10-14:20',
    '14:20-14:30',
    '15:20-15:30',
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
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: GlobalColors.whiteColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Text(
            'Đặt lịch khám',
            style: TextStyle(
              color: GlobalColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.help_outline,
                color: GlobalColors.whiteColor,
                size: 20,
              ),
              label: Text(
                'Hỗ trợ',
                style: TextStyle(color: GlobalColors.whiteColor, fontSize: 14),
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: GlobalColors.bgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: GlobalColors.whiteColor,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    _buildProgressStep('1', 'Chọn lịch khám', true, false),
                    Expanded(
                      child: Container(height: 1, color: Colors.grey.shade300),
                    ),
                    _buildProgressStep('2', 'Xác nhận', false, false),
                    Expanded(
                      child: Container(height: 1, color: Colors.grey.shade300),
                    ),
                    _buildProgressStep('3', 'Nhận lịch hẹn', false, false),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: GlobalColors.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              "https://via.placeholder.com/150",
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bác sĩ chuyên khoa 1",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Vũ Thị Hạnh Thư",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Chuyên khoa: Sản phụ khoa",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: GlobalColors.mainColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Đặt lịch khám này cho:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: GlobalColors.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Họ và tên",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      "Nguyễn Phú Tài",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Giới tính",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      "Nam",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ngày sinh",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      "21/01/2004",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Điện thoại",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      "0788 655 673",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 16),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.all(4),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    "Xem chi tiết",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    foregroundColor: GlobalColors.mainColor,
                                    padding: EdgeInsets.all(4),
                                    backgroundColor: GlobalColors.whiteColor,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    "Sửa hồ sơ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: GlobalColors.mainColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Chọn ngày khám:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

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

                    SizedBox(height: 16),

                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: GlobalColors.mainColor,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Chọn khung giờ khám",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: GlobalColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.black,
                                indicator: BoxDecoration(
                                  color: GlobalColors.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                tabs: [
                                  Tab(text: 'Buổi sáng'),
                                  Tab(text: 'Buổi chiều'),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),

                            SizedBox(
                              height: 100,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Wrap(
                                      runSpacing: 12,
                                      children: List.generate(
                                        timeSlotsMorning.length,
                                        (index) => TimeSlot(
                                          time: timeSlotsMorning[index],
                                          isSelected: selectedIndex == index,
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Wrap(
                                      runSpacing: 12,
                                      children: List.generate(
                                        timeSlotsAfternoon.length,
                                        (index) {
                                          final actualIndex =
                                              index + timeSlotsMorning.length;
                                          return TimeSlot(
                                            time: timeSlotsAfternoon[index],
                                            isSelected:
                                                selectedIndex == actualIndex,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
          color: GlobalColors.whiteColor,
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: Text(
                'Tiếp tục',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStep(
    String number,
    String title,
    bool isActive,
    bool isCompleted,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? GlobalColors.mainColor : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? GlobalColors.mainColor : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
