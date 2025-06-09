import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';

class AppointmentConfirm extends StatefulWidget {
  static final id = 'appointment_confirm';
  const AppointmentConfirm({super.key});

  @override
  State<AppointmentConfirm> createState() => _AppointmentConfirmState();
}

class _AppointmentConfirmState extends State<AppointmentConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.bgColor,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Xử lý khi nhấn nút
            },
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildHeaderItem(
                      '1',
                      'Chọn lịch khám',
                      GlobalColors.corectColor,
                    ),
                    Icon(Icons.arrow_forward_ios, size: 12),
                    buildHeaderItem('2', 'Xác nhận', GlobalColors.mainColor),
                    Icon(Icons.arrow_forward_ios, size: 12),
                    buildHeaderItem(
                      '3',
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
                  fontWeight: FontWeight.w500,
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
                            backgroundImage: AssetImage(
                              GlobalImageIcons.doctor1,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tiến sĩ,Bác sĩ'),
                            Text(
                              'Đào Bùi Quý Quyền',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text('Chuyên khoa: Nội thận, Ngoại tiết niệu'),
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
                                '17:30 - 17:40',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Buổi chiều',
                                style: TextStyle(
                                  color: Colors.amber,
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
                                'Thứ 7',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '07/06/2025',
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
                    buildInfoItem('Chuyên khoa', 'Thận - Tiết niệu'),
                    buildInfoItem(
                      'Bác sĩ',
                      'Tiến sĩ, Bác sĩ ĐÀO BÙI QUÝ QUYỀN',
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
                    buildInfoItem('Họ tên', 'Nguyễn Phú Tài'),
                    buildInfoItem2(
                      'Giới tính',
                      'Ngày sinh',
                      'Nam',
                      '21/01/2004',
                    ),
                    buildInfoItem2(
                      'Điện thoại',
                      'Mã bảo hiểm y tế',
                      '0788655673',
                      '--',
                    ),
                    buildInfoItem('Mã căn cước công dân', 'Chưa cập nhật'),
                    buildInfoItem('Địa chỉ', '--'),
                  ],
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
