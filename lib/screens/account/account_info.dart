import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';
import '../../utils/gobal.images.icons.dart';
import './account_detail_user.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hồ sơ y tế',
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

        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => modalBottomSheetSpecialty(context),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              child: Image.asset(
                GlobalImageIcons.addInfo,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountDetailInfo()),
                );
              },
              child: Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: Image.asset(
                          GlobalImageIcons.detailInfo,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nguyễn Phú Tài',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '+84788655673',
                            style: TextStyle(
                              color: GlobalColors.subTextColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '21/01/2004',
                            style: TextStyle(
                              color: GlobalColors.subTextColor,
                              fontSize: 14,
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

  Widget modalBottomSheetSpecialty(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.43,
          ),
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.close,
                          size: 22,
                          color: GlobalColors.textColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Tạo hồ sơ mới',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: GlobalColors.textColor,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Icon(
                        Icons.exit_to_app,
                        size: 24,
                        color: GlobalColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              buildItem(
                GlobalImageIcons.writeNote,
                'Nhập thông tin',
                'Tạo hồ sơ theo thông tin hành chính',
              ),
              buildItem(
                GlobalImageIcons.scan,
                'Tạo theo mã Bảo hiểm y tế',
                'Quét mã QR Bảo hiểm Y tế để tạo hồ sơ',
              ),
              buildItem(
                GlobalImageIcons.scan,
                'Tạo theo mã CCCD',
                'Quét mã CCCD để tạo hồ sơ',
              ),
            ],
          ),
        ),
        Positioned(
          top: -14,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildItem(String imagePath, String title, String subTitle) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: createInfo(imagePath, title, subTitle: subTitle, onTap: () {}),
  );
}

Widget createInfo(
  String imagePath,
  String title, {
  String subTitle = '',
  VoidCallback? onTap,
}) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    ),
    subtitle:
        subTitle.isNotEmpty
            ? Text(subTitle, style: TextStyle(fontSize: 13))
            : null,
    trailing: Image.asset(imagePath, width: 25, height: 25),
    onTap: onTap,
  );
}
