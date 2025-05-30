import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';

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
          Card(
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

          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.hoSoYTeIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Hồ sơ y tế",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.dsQuanTamIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Danh sách quan tâm",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.dieuKhoanIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Điều khoản và Quy định",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.nhomUserIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Tham gia cộng đồng",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
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
              children: [
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.chiaSeIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Chia sẻ ứng dụng",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.hoTroIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Liên hệ & hỗ trợ",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.caiDatIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Cài đặt",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.dangXuatIcon,
                    width: 22,
                    height: 22,
                  ),
                  title: Text(
                    "Đăng xuất",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
