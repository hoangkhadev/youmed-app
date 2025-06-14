import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/hospital_model.dart';
import 'package:my_flutter_app/services/hospital_service.dart';

import 'package:my_flutter_app/utils/data.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/heading_title.dart';
import 'package:my_flutter_app/widgets/loading.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';
import 'package:my_flutter_app/widgets/toast.dart';

class HomeHospital extends StatefulWidget {
  const HomeHospital({super.key});

  @override
  State<HomeHospital> createState() => _HomeHospitalState();
}

class _HomeHospitalState extends State<HomeHospital> {
  List<HospitalModel>? _hospitals;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialHospitals();
  }

  Future<void> initialHospitals() async {
    try {
      setState(() {
        isLoading = true;
      });
      final hospitalService = HospitalService();
      final result = await hospitalService.getHospitals(limit: 10);

      if (result != null) {
        setState(() {
          _hospitals = result;
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
            iconPath: GlobalImageIcons.hospitalHeadingIcon,
            title: 'Bệnh viện',
            isArrow: true,
          ),
          SizedBox(height: 20),
          Align(
            alignment:
                isLoading || _hospitals == null
                    ? Alignment.center
                    : Alignment.centerLeft,
            child: ScrollableScreenWrapper(
              scrollDirection: Axis.horizontal,
              child:
                  isLoading || _hospitals == null
                      ? Loading()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(_hospitals!.length, (index) {
                          var item = _hospitals![index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < hospitals.length - 1 ? 16 : 0,
                            ),
                            child: hospitalItem(
                              item.imageUrl,
                              item.name,
                              item.address,
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

Widget hospitalItem(String avatarUrl, String name, String address) {
  return Container(
    color: Colors.white,
    width: 300,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 38,
          backgroundImage: NetworkImage(avatarUrl),
          backgroundColor: Colors.grey.shade400,
        ),
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
