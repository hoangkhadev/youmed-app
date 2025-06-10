import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/appointment_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';

class AppointmentPay extends StatefulWidget {
  static final id = 'appointmentpay_screen';
  const AppointmentPay({super.key});

  @override
  State<AppointmentPay> createState() => _AppointmentPayState();
}

class _AppointmentPayState extends State<AppointmentPay> {
  late AppointmentModel appointmentBooked;
  bool _isInitialized = false;

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
    final qrCode = 'YMA2506070960';
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
                  Icon(Icons.check_circle, color: Colors.green, size: 48),
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
                    "12:48:02 07/06/2025",
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
                                  "2",
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
                                data: qrCode,
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
                              backgroundImage: AssetImage(
                                GlobalImageIcons.doctor1,
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
                                    "Lê Thị Minh Hồng",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "250 Nguyễn Xí, P.13, Q. Bình Thạnh, TP.HCM",
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
                        InfoRow(title: "Mã lịch khám", value: qrCode),
                        InfoRow(title: "Ngày khám", value: "T7, 07/06/2025"),
                        InfoRow(
                          title: "Giờ khám",
                          value: "17:05 - 17:10 (Buổi chiều)",
                          valueColor: Colors.green,
                        ),
                        InfoRow(title: "Chuyên khoa", value: "Nhi khoa"),
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
                        InfoRow(title: "Họ và tên", value: "Nguyễn Phú Tài"),
                        InfoRow(title: "Ngày sinh", value: "21/01/2004"),
                        InfoRow(title: "Giới tính", value: "Nam"),
                        InfoRow(title: "Số điện thoại", value: "0788 655 673"),
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
        height: 70,
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
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
