import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/doctor_model.dart';
import 'package:my_flutter_app/screens/search/search_doctordetail.dart';
import 'package:my_flutter_app/services/doctor_service.dart';

import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/heading_title.dart';
import 'package:my_flutter_app/widgets/loading.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';
import 'package:my_flutter_app/widgets/toast.dart';

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({super.key});
  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  List<DoctorModel>? _doctors;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    initialDoctors();
  }

  Future<void> initialDoctors() async {
    try {
      setState(() {
        isLoading = true;
      });
      final doctorService = DoctorService();
      final result = await doctorService.getAllDoctors(limit: 10);

      if (result != null) {
        setState(() {
          _doctors = result;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      Toast.show(
        context: context,
        message: e.toString(),
        type: ToastType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8, top: 6),
      padding: EdgeInsets.all(10),

      child: Column(
        children: [
          HeadingTitle(
            iconPath: GlobalImageIcons.medicalStarIcon,
            title: 'Bác sĩ',
            isArrow: true,
          ),
          SizedBox(height: 20),
          Align(
            alignment:
                isLoading || _doctors == null
                    ? Alignment.center
                    : Alignment.centerLeft,
            child: ScrollableScreenWrapper(
              scrollDirection: Axis.horizontal,
              child:
                  isLoading || _doctors == null
                      ? Loading()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(_doctors!.length, (index) {
                          var item = _doctors![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => DoctorDetail(doctorId: item.id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index < doctors.length - 1 ? 16 : 0,
                              ),
                              child: doctorItem(
                                item.avatarUrl,
                                item.user.fullName.split(' ').last,
                              ),
                            ),
                          );
                        }),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget doctorItem(String avatarUrl, String name) {
  return Column(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(avatarUrl),
        backgroundColor: Colors.grey.shade300,
      ),
      SizedBox(height: 6),
      Text(
        'Bác sĩ $name',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: GlobalColors.textColor,
        ),
      ),
    ],
  );
}
