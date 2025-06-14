import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/appointment_model.dart';
import 'package:my_flutter_app/utils/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:intl/intl.dart';

class AppointmentPay extends StatefulWidget {
  static final id = 'appointmentpay_screen';
  const AppointmentPay({super.key});

  @override
  State<AppointmentPay> createState() => _AppointmentPayState();
}

class _AppointmentPayState extends State<AppointmentPay> {
  late AppointmentModel appointmentBooked;
  bool _isInitialized = false;
  DateTime now = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as AppointmentModel;
      appointmentBooked = args;
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0, // ẩn AppBar
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 32),
                  SizedBox(height: 8),
                  Text(
                    "Đã đặt lịch",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm:ss dd/MM/yyyy').format(now),
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "STT",
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  appointmentBooked.appointmentNumber
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: QrImageView(
                                data: appointmentBooked.id!,
                                version: QrVersions.auto,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                appointmentBooked.doctor.avatarUrl,
                              ),
                              radius: 35,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bác sĩ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    appointmentBooked.doctor.user.fullName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    appointmentBooked.doctor.user.address,
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        45,
                                        45,
                                        45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        InfoRow(
                          title: "Mã lịch khám",
                          value: appointmentBooked.id!,
                        ),
                        InfoRow(
                          title: "Ngày khám",
                          value: Utils.formatDateFromString(
                            appointmentBooked.datetime,
                          ),
                        ),
                        InfoRow(
                          title: "Giờ khám",
                          value:
                              "${appointmentBooked.snapshotTimeSlot.startTime} - ${appointmentBooked.snapshotTimeSlot.endTime} (${appointmentBooked.snapshotTimeSlot.session == 'morning' ? 'Buổi sáng' : 'Buổi chiều'})",
                          valueColor: Colors.green,
                        ),
                        InfoRow(
                          title: "Chuyên khoa",
                          value: appointmentBooked.doctor.specializations
                              .map((s) => s.name)
                              .join(', '),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              "THÔNG TIN BỆNH NHÂN",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),
                        InfoRow(
                          title: "Họ và tên",
                          value: appointmentBooked.patient.fullName,
                        ),
                        InfoRow(
                          title: "Ngày sinh",
                          value: appointmentBooked.patient.dobFormated,
                        ),
                        InfoRow(
                          title: "Giới tính",
                          value:
                              appointmentBooked.patient.gender == 'male'
                                  ? 'Nam'
                                  : 'Nữ',
                        ),
                        InfoRow(
                          title: "Số điện thoại",
                          value: appointmentBooked.patient.phone,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: GlobalColors.whiteColor,
          border: Border(
            top: BorderSide(
              style: BorderStyle.solid,
              color: const Color.fromARGB(255, 197, 197, 197),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Container(
                width: 170,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Text(
                    "Về trang chủ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, MainScreen.id);
              },
            ),

            GestureDetector(
              child: Container(
                width: 170,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(7),
                  color: GlobalColors.mainColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 20,
                        child: Image.asset(
                          GlobalImageIcons.messageChat,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Chat với bác sĩ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: GlobalColors.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const InfoRow({
    required this.title,
    required this.value,
    this.valueColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(title, style: TextStyle(color: Colors.grey[700])),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(color: valueColor ?? Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
