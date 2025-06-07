import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';

class AccountDetailInfo extends StatefulWidget {
  const AccountDetailInfo({super.key});
  @override
  State<AccountDetailInfo> createState() => _AccountDetailInfoState();
}

class _AccountDetailInfoState extends State<AccountDetailInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hồ sơ của bạn',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_outlined),
        ),
        foregroundColor: Colors.white,
        backgroundColor: GlobalColors.mainColor,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: Image.asset(GlobalImageIcons.userInfo),
                ),
              ),
              Text(
                'Thông tin cơ bản',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 0, 69, 187),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Điều chỉnh',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 0, 69, 187),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('THẺ CĂN CƯỚC CÔNG DÂN'),
              trailing: SizedBox(
                height: 25,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor,
                    foregroundColor: GlobalColors.whiteColor,
                  ),
                  child: Text('Cập nhật', style: TextStyle(fontSize: 12)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Mã bệnh nhân',
              context,
              'YMP252218854',
              showTrailing: true,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Họ tên',
              context,
              'Nguyễn Phú Tài',
              showTrailing: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Số điện thoại',
              context,
              '0788655673',
              showTrailing: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Ngày sinh',
              context,
              '21/01/2004',
              showTrailing: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem('Giới tính', context, 'Nam', showTrailing: false),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Địa chỉ',
              context,
              'Chưa cập nhật',
              showTrailing: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Dân tộc',
              context,
              'Chưa cập nhật',
              showTrailing: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Nghề nghiệp',
              context,
              'Chưa cập nhật',
              showTrailing: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: infoItem(
              'Email',
              context,
              'nphutai49@gmail.com',
              showTrailing: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('THÔNG TIN BẢO HIỂM Y TẾ'),
              trailing: SizedBox(
                height: 25,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor,
                    foregroundColor: GlobalColors.whiteColor,
                  ),
                  child: Text('Cập nhật', style: TextStyle(fontSize: 12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget infoItem(
  String title,
  BuildContext context,
  String subTitle, {
  bool showTrailing = false,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    visualDensity: VisualDensity.compact,
    title: Text(title, style: TextStyle(fontSize: 14)),
    subtitle:
        subTitle.isNotEmpty
            ? Text(
              subTitle,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            )
            : null,
    trailing:
        showTrailing
            ? GestureDetector(
              onTap: () {
                showCopiedSnackBar(context);
              },
              child: Image.asset(GlobalImageIcons.copy, height: 20, width: 20),
            )
            : null,
  );
}

void showCopiedSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Align(alignment: Alignment.center, child: Text('Đã sao chép!')),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
    ),
  );
}
