import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/account/account_screen.dart';
import 'package:my_flutter_app/screens/appointment/appointment_screen.dart';
import 'package:my_flutter_app/screens/home/home_body.dart';
import 'package:my_flutter_app/screens/message/message_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';

import 'package:my_flutter_app/widgets/nav_item.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeBody(),
    AppointmentScreen(),
    MessageScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.bgColor,
      body: ScrollableScreenWrapper(
        child: SafeArea(child: Center(child: _screens[_selectedIndex])),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 231, 231, 231), // màu viền top
              width: 1.0, // độ dày viền
            ),
          ),
        ),
        child: BottomAppBar(
          color: GlobalColors.whiteColor,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavItem(
                imagePath: GlobalImageIcons.homeIcon,
                imageActivePath: GlobalImageIcons.homeActiveIcon,
                label: 'Trang chủ',
                isSelected: _selectedIndex == 0,
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              SizedBox(width: 8),
              NavItem(
                imagePath: GlobalImageIcons.calendarIcon,
                imageActivePath: GlobalImageIcons.calendarActiveIcon,
                label: 'Lịch khám',
                isSelected: _selectedIndex == 1,
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              SizedBox(width: 8),
              NavItem(
                imagePath: GlobalImageIcons.chatBubbleIcon,
                imageActivePath: GlobalImageIcons.chatBubbleActiveIcon,
                label: 'Tin nhắn',
                isSelected: _selectedIndex == 2,
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              SizedBox(width: 8),
              NavItem(
                imagePath: GlobalImageIcons.useAccountIcon,
                imageActivePath: GlobalImageIcons.useAccountActiveIcon,
                label: 'Tài khoản',
                isSelected: _selectedIndex == 3,
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
