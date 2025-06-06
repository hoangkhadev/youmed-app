import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/account/account_info.dart';
import 'package:my_flutter_app/screens/auth/login_screen.dart';
import 'package:my_flutter_app/screens/auth/register_info_form_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/custom_card.dart';
import 'package:my_flutter_app/widgets/custom_dialog.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
              Navigator.pushNamed(context, LoginScreen.id);
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12),
          child: ScrollableScreenWrapper(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AccountInfo.id);
                  },
                  child: CustomCard(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          if (auth.isLoggedIn) ...[
                            const CircleAvatar(
                              radius: 26,
                              backgroundColor: Color.fromARGB(
                                255,
                                190,
                                187,
                                187,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  auth.currentUser!.fullName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  auth.currentUser!.phone,
                                  style: TextStyle(
                                    color: GlobalColors.subTextColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ] else
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Chưa là thành viên?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: GlobalColors.textColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Đăng ký hoặc đăng nhập ngay',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: GlobalColors.textColor,
                                    ),
                                  ),
                                  SizedBox(height: 6),

                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        GlobalColors.mainColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        LoginScreen.id,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.person_add,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    label: Text(
                                      'Đăng ký / Đăng nhập',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                CustomCard(
                  child: Column(
                    children: [
                      accountItem(
                        GlobalImageIcons.hoSoYTeIcon,
                        'Hồ sơ y tế',
                        onTap: () {
                          if (auth.isLoggedIn) {
                            Navigator.pushNamed(context, AccountInfo.id);
                          } else {
                            _showLoginDialog(context);
                          }
                        },
                      ),
                      accountItem(
                        GlobalImageIcons.dsQuanTamIcon,
                        'Danh sách quan tâm',
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
                CustomCard(
                  child: Column(
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
                      accountItem(
                        GlobalImageIcons.caiDatIcon,
                        'Cài đặt',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RegisterInfoFormScreen.id,
                          );
                        },
                      ),
                      if (auth.isLoggedIn)
                        accountItem(
                          onTap: () async {
                            final auth = context.read<AuthProvider>();
                            await auth.logout();

                            if (context.mounted) {
                              Navigator.pushNamed(context, LoginScreen.id);
                            }
                          },
                          GlobalImageIcons.dangXuatIcon,
                          'Đăng xuất',
                          showTrailing: false,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
    contentPadding: EdgeInsets.symmetric(horizontal: 12),
    dense: true,
    leading: Image.asset(imagePath, width: 20, height: 20),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    ),
    subtitle: subTitle.isNotEmpty ? Text(subTitle) : null,
    trailing:
        showTrailing ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
    onTap: onTap,
  );
}
