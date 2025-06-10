import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_flutter_app/models/appointment_model.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/models/schedule_model.dart';
import 'package:my_flutter_app/utils/utils.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/home/home_screen.dart';
import 'package:my_flutter_app/services/appointment_service.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/overlay.dart';
import 'package:my_flutter_app/widgets/toast.dart';
import 'package:provider/provider.dart';

class AppointmentConfirm extends StatefulWidget {
  static final id = 'appointment_confirm';
  const AppointmentConfirm({super.key});

  @override
  State<AppointmentConfirm> createState() => _AppointmentConfirmState();
}

class _AppointmentConfirmState extends State<AppointmentConfirm> {
  final TextEditingController _reasonController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late DoctorModel doctor;
  late DateTime selectedDate;
  late String selectedSession;
  late TimeSlot timeSlot;

  final loading = LoadingOverlay();

  @override
  void dispose() {
    super.dispose();
    _reasonController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeDateFormatting();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final slotInfo = args['slotInfo'] as Map<String, dynamic>;

    doctor = args['doctor'] as DoctorModel;
    selectedDate = slotInfo['date'] as DateTime;
    selectedSession = slotInfo['session'] as String;
    timeSlot = slotInfo['timeSlot'] as TimeSlot;
  }

  void _initializeDateFormatting() async {
    await initializeDateFormatting('vi', null);
  }

  Future<void> handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      loading.show(context);
      final user = context.read<AuthProvider>().currentUser;

      final appointment = AppointmentModel(
        patient: user!,
        doctor: doctor,
        datetime: Utils.covertDateTimeSendServer(selectedDate),
        snapshotTimeSlot: SnapshotTimeSlot(
          session: selectedSession,
          startTime: timeSlot.startTime,
          endTime: timeSlot.endTime,
        ),
        reason: _reasonController.text.trim(),
      );

      final appointmentService = AppointmentService();
      final result = await appointmentService.createAppointment(appointment);

      if (result != null) {
        print(">>> check result: $result");
        if (!mounted) return;
        loading.hide();
        Toast.show(
          context: context,
          message: 'Đặt lịch thành công',
          type: ToastType.success,
        );
        // Navigator.pushNamed(context, HomeScreen.id, arguments: );
      }
    } catch (e) {
      if (!mounted) return;

      loading.hide();
      Toast.show(
        context: context,
        message: e.toString(),
        type: ToastType.error,
        duration: 10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      backgroundColor: GlobalColors.bgColor,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: GlobalColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'XÁC NHẬN ĐẶT LỊCH',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 5,
        centerTitle: true,
        title: const Text(
          'Xác nhận thông tin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildHeaderItem('1', 'Xác nhận', GlobalColors.mainColor),
                    Icon(Icons.arrow_forward_ios, size: 12),
                    buildHeaderItem(
                      '2',
                      'Nhận lịch hẹn',
                      GlobalColors.greyColor,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 13, top: 25, bottom: 10),
              child: Text(
                'THÔNG TIN ĐĂNG KÝ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: GlobalColors.textColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: GlobalColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(doctor.avatarUrl),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bác sĩ'),
                            Text(
                              doctor.user.fullName,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Chuyên khoa: ${doctor.specializations.map((s) => s.name).toList().join(', ')}',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: const Color.fromARGB(255, 225, 225, 225),
                      thickness: 0.5,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Giờ khám'),
                              Text(
                                '${timeSlot.startTime} - ${timeSlot.endTime}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                selectedSession == 'morning'
                                    ? 'Buổi sáng'
                                    : 'Buổi chiều',
                                style: TextStyle(
                                  color:
                                      selectedSession == 'morning'
                                          ? Colors.blue
                                          : Colors.amber,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ngày khám'),
                              Text(
                                DateFormat('EEEE', 'vi').format(selectedDate),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                Utils.formatDate(selectedDate),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    buildInfoItem(
                      'Chuyên khoa',
                      doctor.specializations
                          .map((s) => s.name)
                          .toList()
                          .join(' - '),
                    ),
                    buildInfoItem(
                      'Bác sĩ',
                      '${doctor.title} ${doctor.user.fullName}',
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          child: Text('THÔNG TIN BỆNH NHÂN'),
                        ),

                        Expanded(
                          child: Divider(color: Colors.grey, thickness: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(Icons.expand_more, color: Colors.grey),
                        ),
                      ],
                    ),
                    buildInfoItem('Họ tên', user!.fullName),
                    buildInfoItem2(
                      'Giới tính',
                      'Ngày sinh',
                      user.gender == 'male' ? 'Nam' : 'Nữ',
                      user.dobFormated,
                    ),
                    buildInfoItem2(
                      'Điện thoại',
                      'Mã bảo hiểm y tế',
                      user.phone,
                      '--',
                    ),
                    buildInfoItem('Mã căn cước công dân', 'Chưa cập nhật'),
                    buildInfoItem('Địa chỉ', user.address),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: GlobalColors.textColor,
                  ),
                  children: [
                    TextSpan(text: 'Lý do khám'),
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red.shade600),
                    ),
                  ],
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextFormField(
                  controller: _reasonController,
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nhập lý do khám...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: GlobalColors.mainColor,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.red.shade800,
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lý do khám';
                    }
                    return null;
                  },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'CHI TIẾT THANH TOÁN',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: GlobalColors.textColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: GlobalColors.whiteColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phí khám',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '0đ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color.fromARGB(255, 225, 225, 225),
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phí tiện ích',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Miễn phí',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color.fromARGB(255, 225, 225, 225),
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng thanh toán',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '0đ',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
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

Widget buildHeaderItem(String step, String content, Color color) {
  return Row(
    children: [
      CircleAvatar(
        radius: 10,
        backgroundColor: color,
        child: Text(
          step,
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          content,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

Widget buildInfoItem(String title, String content) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(
          content,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget buildInfoItem2(
  String title1,
  String title2,
  String content1,
  String content2,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 20, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1),
            Text(
              content1,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title2),
            Text(
              content2,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      SizedBox(width: 10),
    ],
  );
}
