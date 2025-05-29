import 'package:flutter/material.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static final id = 'account_screen';
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 30, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nguyễn Phú Tài',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+84788655673',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.hoSoYTeIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Hồ sơ y tế"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.dsQuanTamIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Danh sách quan tâm"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.dieuKhoanIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Điều khoản và Quy định"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.nhomUserIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Tham gia cộng đồng"),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.chiaSeIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Chia sẻ ứng dụng"),
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.hoTroIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Liên hệ & hỗ trợ"),
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.caiDatIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Cài đặt"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    GlobalImageIcons.dangXuatIcon,
                    width: 24,
                    height: 24,
                  ),
                  title: Text("Đăng xuất"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
