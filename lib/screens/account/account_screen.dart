import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';
import '../../utils/global.images.icons.dart';

import './account_info.dart';
import 'account_detail_user.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AccountDetailInfo()),
              );
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Color.fromARGB(255, 190, 187, 187),
                      child: Icon(Icons.person, size: 30, color: Colors.white),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                accountItem(
                  GlobalImageIcons.hoSoYTeIcon,
                  'Hồ sơ y tế',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountInfo(),
                      ),
                    );
                  },
                ),
                accountItem(
                  GlobalImageIcons.dsQuanTamIcon,
                  'Danh sách quan tâm',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountInfo(),
                      ),
                    );
                  },
                ),
                accountItem(
                  GlobalImageIcons.dieuKhoanIcon,
                  'Điều khoản và quy định',
                ),
                accountItem(
                  GlobalImageIcons.nhomUserIcon,
                  'Tham gia cộng đồng',
                  showTrailing: false,
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                accountItem(
                  GlobalImageIcons.chiaSeIcon,
                  'Chia sẻ ứng dụng',
                  showTrailing: false,
                ),
                accountItem(
                  GlobalImageIcons.hoTroIcon,
                  'Liên hệ & hỗ trợ',
                  showTrailing: false,
                ),
                accountItem(GlobalImageIcons.caiDatIcon, 'Cài đặt'),
                accountItem(
                  GlobalImageIcons.dangXuatIcon,
                  'Đăng xuất',
                  showTrailing: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget accountItem(
  String imagePath,
  String title, {
  String subTitle = '',
  bool showTrailing = true,
  VoidCallback? onTap,
}) {
  return ListTile(
    leading: Image.asset(imagePath, width: 22, height: 22),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    ),
    subtitle: subTitle.isNotEmpty ? Text(subTitle) : null,
    trailing:
        showTrailing ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
    onTap: onTap,
  );
}
