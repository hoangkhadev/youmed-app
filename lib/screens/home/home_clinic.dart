import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/clinic_model.dart';
import 'package:my_flutter_app/services/clinic_service.dart';

import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/heading_title.dart';
import 'package:my_flutter_app/widgets/loading.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';
import 'package:my_flutter_app/widgets/toast.dart';

class HomeClinic extends StatefulWidget {
  const HomeClinic({super.key});

  @override
  State<HomeClinic> createState() => _HomeClinicState();
}

class _HomeClinicState extends State<HomeClinic> {
  List<ClinicModel>? _clinics;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialClinics();
  }

  Future<void> initialClinics() async {
    try {
      setState(() {
        isLoading = true;
      });
      final clinicService = ClinicService();
      final result = await clinicService.getClinics(limit: 10);

      if (result != null) {
        setState(() {
          _clinics = result;
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
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),

      child: Column(
        children: [
          HeadingTitle(
            iconPath: GlobalImageIcons.clinicIcon,
            title: 'Phòng khám',
            isArrow: true,
          ),
          SizedBox(height: 20),
          Align(
            alignment:
                isLoading || _clinics == null
                    ? Alignment.center
                    : Alignment.centerLeft,
            child: ScrollableScreenWrapper(
              scrollDirection: Axis.horizontal,
              child:
                  isLoading || _clinics == null
                      ? Loading()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(clinics.length, (index) {
                          var item = clinics[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < clinics.length - 1 ? 16 : 0,
                            ),
                            child: clinicItem(
                              item['image']!,
                              item['name']!,
                              item['address']!,
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

Widget clinicItem(String avatarUrl, String name, String address) {
  return Container(
    color: Colors.white,
    width: 300,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(radius: 38, backgroundImage: AssetImage(avatarUrl)),
        SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: GlobalColors.textColor,
                ),
              ),
              SizedBox(height: 2),
              Text(
                address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: GlobalColors.subTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
