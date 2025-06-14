import 'package:flutter/material.dart';

import 'package:my_flutter_app/screens/account/account_screen.dart';
import 'package:my_flutter_app/screens/appointment/appointment_screen.dart';
import 'package:my_flutter_app/screens/home/home_screen.dart';
import 'package:my_flutter_app/screens/message/message_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';

class MainScreen extends StatefulWidget {
  final int currentIndex;
  const MainScreen({super.key, this.currentIndex = 0});
  static final String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  final GlobalKey<AppointmentScreenState> appointmentScreenKey =
      GlobalKey<AppointmentScreenState>();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      AppointmentScreen(key: appointmentScreenKey),
      MessageScreen(),
      AccountScreen(),
    ];
    _currentIndex = widget.currentIndex.clamp(0, _screens.length - 1);
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      if (index == 1) {
        appointmentScreenKey.currentState?.initialAppointments();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: SizedBox(
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: GlobalColors.mainColor,
            unselectedItemColor: GlobalColors.textColor,
            backgroundColor: Colors.white,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
            items: [
              _customNavigationBarItem(
                GlobalImageIcons.homeIcon,
                GlobalImageIcons.homeActiveIcon,
                'Trang chủ',
              ),
              _customNavigationBarItem(
                GlobalImageIcons.calendarIcon,
                GlobalImageIcons.calendarActiveIcon,
                'Lịch khám',
              ),
              _customNavigationBarItem(
                GlobalImageIcons.chatBubbleIcon,
                GlobalImageIcons.chatBubbleActiveIcon,
                'Tin nhắn',
              ),
              _customNavigationBarItem(
                GlobalImageIcons.useAccountIcon,
                GlobalImageIcons.useAccountActiveIcon,
                'Tài khoản',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BottomNavigationBarItem _customNavigationBarItem(
  String icon,
  String iconActive,
  String label,
) {
  final double iconSize = 20;
  final double spacing = 4;
  return BottomNavigationBarItem(
    icon: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon, width: iconSize, height: iconSize),
        SizedBox(height: spacing),
      ],
    ),
    activeIcon: Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconActive, width: iconSize, height: iconSize),
          SizedBox(height: spacing),
        ],
      ),
    ),
    label: label,
    tooltip: label,
  );
}
