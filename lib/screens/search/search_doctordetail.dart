import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/models/schedule_model.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/appointment/appointment_confirm.dart';
import 'package:my_flutter_app/screens/auth/login_screen.dart';
import 'package:my_flutter_app/services/doctor_service.dart';
import 'package:my_flutter_app/widgets/custom_dialog.dart';
import 'package:my_flutter_app/widgets/loading.dart';
import 'package:my_flutter_app/widgets/time_slot.dart';
import 'package:my_flutter_app/widgets/toast.dart';
import 'package:provider/provider.dart';
import '../../utils/global.images.icons.dart';
import '../../widgets/schedule_weekdays.dart';
import '../../utils/global.colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:collection/collection.dart';

class DoctorDetail extends StatefulWidget {
  static final id = 'doctor_detail_screen';
  final String doctorId;

  const DoctorDetail({super.key, required this.doctorId});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  DoctorModel? _doctor;
  DateTime selectedDate = DateTime.now();
  ScheduleModel? selectedSchedule;
  String? selectedTimeSlotId;
  String? selectedSession;
  TimeSlot? selectedTimeSlot;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDoctor();
    _updateSelectedSchedule();
  }

  Future<void> _loadDoctor() async {
    try {
      setState(() {
        isLoading = true;
      });
      final doctorService = DoctorService();
      final result = await doctorService.getDoctorById(widget.doctorId);
      setState(() {
        _doctor = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      Toast.show(
        context: context,
        message: e.toString(),
        type: ToastType.error,
      );
    }
  }

  void _updateSelectedSchedule() {
    try {
      if (_doctor != null) {
        selectedSchedule = _doctor!.schedules.firstWhereOrNull((schedule) {
          final scheduleDate = schedule.date.toLocal();
          return scheduleDate.year == selectedDate.year &&
              scheduleDate.month == selectedDate.month &&
              scheduleDate.day == selectedDate.day;
        });
        selectedTimeSlotId = null;
        selectedSession = null;
        selectedTimeSlot = null;
      }
    } catch (e) {
      selectedSchedule = null;
      selectedTimeSlotId = null;
      selectedSession = null;
      selectedTimeSlot = null;
    }
  }

  Map<String, dynamic>? getSelectedSlotInfo() {
    if (selectedTimeSlotId == null ||
        selectedSession == null ||
        selectedSchedule == null) {
      return null;
    }

    final session = selectedSchedule!.sessions.firstWhere(
      (s) => s.session == selectedSession,
    );

    final timeSlot = session.timeSlots.firstWhere(
      (slot) => slot.id == selectedTimeSlotId,
    );
    selectedTimeSlot = timeSlot;
    return {
      'date': selectedDate,
      'session': selectedSession,
      'timeSlot': timeSlot,
      'startTime': timeSlot.startTime,
      'endTime': timeSlot.endTime,
    };
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (_) => CustomDialog(
            title: 'Yêu cầu đăng nhập',
            description: 'Bạn cần phải đăng nhập để sử dụng chức năng này!',
            cancleText: 'Hủy',
            confirmText: 'Đăng nhập',
            onConfirm: () {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: GlobalColors.whiteColor,
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          'Thông tin bác sĩ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,

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

      body:
          _doctor == null
              ? Loading()
              : SingleChildScrollView(
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
                                backgroundImage: NetworkImage(
                                  _doctor!.avatarUrl,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _doctor!.user.fullName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Image.asset(
                                            GlobalImageIcons.certification,
                                            width: 18,
                                            height: 18,
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
                                    SizedBox(height: 2),
                                    Text(
                                      '${_doctor!.experienceYears} năm kinh nghiệm',
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Chuyên khoa: ',
                                style: TextStyle(fontSize: 14),
                              ),

                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _doctor!.specializations
                                      .map((e) => e.name)
                                      .toList()
                                      .join(', '),
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
                                    selectedDate = date;
                                    _updateSelectedSchedule();
                                    setState(() {});
                                  },
                                  schedules:
                                      _doctor!.schedules.where((schedule) {
                                        DateTime today = DateTime.now();
                                        DateTime scheduleDate = schedule.date;

                                        // Tính số ngày chênh lệch
                                        int daysDifference =
                                            scheduleDate
                                                .difference(today)
                                                .inDays;

                                        return daysDifference >=
                                            0; // Từ hôm nay trở đi
                                      }).toList(),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),
                          if (selectedSchedule != null) ...[
                            if (selectedSchedule!.sessions.any(
                              (s) => s.session == "morning",
                            )) ...[
                              const Text(
                                "Buổi sáng",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      selectedSchedule!.sessions
                                          .where((s) => s.session == 'morning')
                                          .expand(
                                            (session) => session.timeSlots,
                                          )
                                          .map((timeSlot) {
                                            final isSelected =
                                                selectedTimeSlotId ==
                                                    timeSlot.id &&
                                                selectedSession == 'morning';

                                            return TimeSlotItem(
                                              time:
                                                  "${timeSlot.startTime} - ${timeSlot.endTime}",
                                              isSelected: isSelected,
                                              isBooked: timeSlot.isBooked,
                                              onTap: () {
                                                if (!timeSlot.isBooked) {
                                                  setState(() {
                                                    if (selectedTimeSlotId ==
                                                            timeSlot.id &&
                                                        selectedSession ==
                                                            'morning') {
                                                      // Bỏ chọn nếu click vào slot đã chọn
                                                      selectedTimeSlotId = null;
                                                      selectedSession = null;
                                                    } else {
                                                      // Chọn slot mới
                                                      selectedTimeSlotId =
                                                          timeSlot.id;
                                                      selectedSession =
                                                          'morning';
                                                    }
                                                  });
                                                }
                                              },
                                            );
                                          })
                                          .toList(),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],

                            if (selectedSchedule!.sessions.any(
                              (s) => s.session == "afternoon",
                            )) ...[
                              const Text(
                                "Buổi chiều",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      selectedSchedule!.sessions
                                          .where(
                                            (s) => s.session == 'afternoon',
                                          )
                                          .expand(
                                            (session) => session.timeSlots,
                                          )
                                          .map((timeSlot) {
                                            final isSelected =
                                                selectedTimeSlotId ==
                                                    timeSlot.id &&
                                                selectedSession == 'afternoon';

                                            return TimeSlotItem(
                                              time:
                                                  "${timeSlot.startTime} - ${timeSlot.endTime}",
                                              isSelected: isSelected,
                                              isBooked: timeSlot.isBooked,
                                              onTap: () {
                                                if (!timeSlot.isBooked) {
                                                  setState(() {
                                                    if (selectedTimeSlotId ==
                                                            timeSlot.id &&
                                                        selectedSession ==
                                                            'afternoon') {
                                                      selectedTimeSlotId = null;
                                                      selectedSession = null;
                                                    } else {
                                                      selectedTimeSlotId =
                                                          timeSlot.id;
                                                      selectedSession =
                                                          'afternoon';
                                                    }
                                                  });
                                                }
                                              },
                                            );
                                          })
                                          .toList(),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ] else ...[
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                "Không có lịch khám cho ngày này",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
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
                          const SizedBox(height: 6),
                          Html(data: _doctor!.bio),
                          const SizedBox(height: 6),
                          if (_doctor!.position.isNotEmpty) ...[
                            const Text(
                              "Chức vụ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(_doctor!.position),
                            const SizedBox(height: 6),
                          ],
                          const Text(
                            "Công tác",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(_doctor!.workplace),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),

      bottomNavigationBar: SizedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: GlobalColors.mainColor,
                        width: 1.5,
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
                            fontWeight: FontWeight.w700,
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
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 1.5,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        child: Text(
                          'Gọi video',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade600,
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
                        onPressed:
                            !auth.isLoggedIn
                                ? () => _showLoginDialog(context)
                                : () {
                                  final slotInfo = getSelectedSlotInfo();
                                  if (slotInfo != null) {
                                    final dataToSend = {
                                      'slotInfo': slotInfo,
                                      'doctor': _doctor,
                                    };

                                    Navigator.pushNamed(
                                      context,
                                      AppointmentConfirm.id,
                                      arguments: dataToSend,
                                    );
                                  } else {
                                    Toast.show(
                                      context: context,
                                      message:
                                          'Vui lòng chọn ngày và khung giờ khám',
                                      type: ToastType.error,
                                    );
                                  }
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
    );
  }
}
