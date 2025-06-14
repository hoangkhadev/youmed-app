import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/models/locations_model.dart';

import 'package:my_flutter_app/models/user_model.dart';
import 'package:my_flutter_app/screens/selected_city_screen.dart';
import 'package:my_flutter_app/screens/selected_district_screen.dart';
import 'package:my_flutter_app/screens/selected_ward_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/utils/utils.dart';
import 'package:my_flutter_app/widgets/custom_bottom_sheet.dart';

class ProfileForm extends StatefulWidget {
  final UserModel? initialData;
  final GlobalKey<FormState> formKey;
  final bool isRegister;

  const ProfileForm({
    super.key,
    this.initialData,
    required this.formKey,
    this.isRegister = true,
  });

  @override
  State<ProfileForm> createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  late bool _isRegister;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  late TextEditingController _districtController;
  late TextEditingController _wardController;
  late TextEditingController _address2Controller;
  String gender = 'male';
  DateTime selectedDate = DateTime.now();

  Map<String, dynamic> getFormData() {
    return {
      'full_name': _nameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'dob': Utils.covertDateTimeSendServer(selectedDate),
      'email': _emailController.text.trim(),
      'city': _cityController.text,
      'district': _districtController.text,
      'ward': _wardController.text,
      'address2': _address2Controller.text.trim(),
      'gender': gender,
    };
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _wardController.dispose();
    _address2Controller.dispose();
    super.dispose();
  }

  List<City> cities = [];
  City? selectedCity;
  District? selectedDistrict;
  Ward? selectedWard;

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;

    _nameController = TextEditingController(text: data?.fullName ?? '');
    _phoneController = TextEditingController(text: data?.phone ?? '');
    _dobController = TextEditingController(text: data?.dobFormated ?? '');
    _emailController = TextEditingController(text: data?.email ?? '');
    _address2Controller = TextEditingController(text: data?.address2 ?? '');
    gender = data?.gender ?? 'male';

    _cityController = TextEditingController();
    _districtController = TextEditingController();
    _wardController = TextEditingController();

    _isRegister = widget.isRegister;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocationData(data);
    });
  }

  Future<void> _initializeLocationData(UserModel? data) async {
    await loadCities();

    if (data != null && cities.isNotEmpty) {
      await _setLocationFromData(data);
    }
  }

  Future<void> loadCities() async {
    try {
      final locationData = await rootBundle.loadString('assets/locations.json');
      final List<dynamic> jsonList = jsonDecode(locationData);

      setState(() {
        cities =
            jsonList
                .where((json) => json != null)
                .map((json) => City.fromJson(json as Map<String, dynamic>))
                .toList();
      });
    } catch (e) {
      setState(() {
        cities = []; // Set về list rỗng nếu có lỗi
      });
    }
  }

  Future<void> _setLocationFromData(UserModel data) async {
    if (data.city.isNotEmpty == true) {
      selectedCity = cities.cast<City?>().firstWhere(
        (city) => city!.name.toLowerCase() == data.city.toLowerCase(),
        orElse: () => null,
      );

      if (selectedCity != null) {
        _cityController.text = selectedCity!.name;

        // Set district
        if (data.district.isNotEmpty == true) {
          selectedDistrict = selectedCity!.districts
              .cast<District?>()
              .firstWhere(
                (district) =>
                    district?.name.toLowerCase() == data.district.toLowerCase(),
                orElse: () => null,
              );

          if (selectedDistrict != null) {
            _districtController.text = selectedDistrict!.name;

            // Set ward
            if (data.ward.isNotEmpty == true) {
              selectedWard = selectedDistrict!.wards.cast<Ward?>().firstWhere(
                (ward) => ward!.name.toLowerCase() == data.ward.toLowerCase(),
                orElse: () => null,
              );

              if (selectedWard != null) {
                _wardController.text = selectedWard!.name;
              }
            }
          }
        }
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          buildTextField(
            label: 'Họ và tên',
            hintText: 'Họ và tên của bạn',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập họ và tên';
              } else if (value.trim().length < 2) {
                return 'Họ và tên phải từ 2 kí tự';
              }
              return null;
            },
          ),

          buildTextField(
            label: 'Số điện thoại',
            hintText: '0901234567',
            readOnly: _isRegister,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập số điện thoại';
              }

              String trimmedValue = value.trim();

              if (trimmedValue.length != 10) {
                return 'Số điện thoại phải có đúng 10 chữ số';
              }

              final phoneRegex = RegExp(r'^(0)(3|5|7|8|9)[0-9]{8}$');
              if (!phoneRegex.hasMatch(trimmedValue)) {
                return 'Số điện thoại không hợp lệ';
              }

              return null;
            },
          ),

          buildTextField(
            label: 'Ngày sinh',
            hintText: 'Ngày sinh của bạn',
            controller: _dobController,
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {
                CustomBottomSheet.show(
                  context: context,
                  child: buildDatePicker(controller: _dobController),
                );
              },
              icon: Image.asset(
                GlobalImageIcons.dateTimePickerIcon,
                width: 26,
                height: 26,
              ),
            ),
            onTap: () {
              CustomBottomSheet.show(
                context: context,
                child: buildDatePicker(controller: _dobController),
              );
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng chọn ngày sinh';
              }
              return null;
            },
          ),

          buildGenderField(),

          buildTextField(
            label: 'Địa chỉ email',
            hintText: 'Địa chỉ email của bạn',
            controller: _emailController,
            isRequired: false,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                String trimmedValue = value.trim();
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(trimmedValue)) {
                  return 'Email không hợp lệ';
                }
              }
              return null;
            },
          ),
          buildTextField(
            label: 'Tỉnh/Thành phố',
            hintText: 'Chọn Tỉnh/Thành phố',
            controller: _cityController,
            readOnly: true,
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: GlobalColors.grayColor,
            ),
            onTap: () async {
              final result = await Navigator.push<City>(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => SelectedCityScreen(
                        cities: cities,
                        selectedCity: selectedCity,
                      ),
                ),
              );
              if (result != null) {
                setState(() {
                  selectedCity = result;
                  _cityController.text = result.name;

                  selectedDistrict = null;
                  selectedWard = null;
                  _districtController.text = '';
                  _wardController.text = '';
                });
              }
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng chọn tỉnh/thành phố';
              }
              return null;
            },
          ),
          buildTextField(
            label: 'Quận/Huyện',
            hintText: 'Chọn Quận/Huyện',
            controller: _districtController,
            readOnly: true,
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: GlobalColors.grayColor,
            ),
            onTap: () async {
              final districtResult = await Navigator.push<District>(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => SelectedDistrictScreen(
                        districts:
                            selectedCity!
                                .districts, // danh sách quận huyện của thành phố
                        selectedDistrict: selectedDistrict,
                      ),
                ),
              );

              if (districtResult != null) {
                setState(() {
                  selectedDistrict = districtResult;
                  _districtController.text = districtResult.name;

                  selectedWard = null;
                  _wardController.text = '';
                });
              }
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng chọn quận/huyện';
              }
              return null;
            },
          ),
          buildTextField(
            label: 'Phường/Xã',
            hintText: 'Chọn Phường/Xã',
            controller: _wardController,
            readOnly: true,
            suffixIcon: Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: GlobalColors.grayColor,
            ),
            onTap: () async {
              final wardResult = await Navigator.push<Ward>(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => SelectedWardScreen(
                        wards:
                            selectedDistrict!
                                .wards, // danh sách quận huyện của thành phố
                        selectedWard: selectedWard,
                      ),
                ),
              );

              if (wardResult != null) {
                setState(() {
                  selectedWard = wardResult;
                  _wardController.text = wardResult.name;
                });
              }
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng chọn phường/xã';
              }
              return null;
            },
          ),
          buildTextField(
            label: 'Số nhà, tên đường',
            hintText: 'Ví dụ: Số 523, Đường Nguyễn Văn A',
            isRequired: false,
            readOnly: false,
            controller: _address2Controller,
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    bool readOnly = false,
    bool isRequired = true,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: GlobalColors.textColor,
              ),
              children: [
                TextSpan(text: label),
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red.shade600),
                  ),
              ],
            ),
          ),
          SizedBox(height: 4),
          TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            controller: controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w600,
              ),
              floatingLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: GlobalColors.mainColor,
                  width: 1.5,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red.shade800, width: 1.5),
              ),
            ),
            keyboardType: keyboardType,
            validator: validator,
          ),
        ],
      ),
    );
  }

  Widget buildGenderField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              text: "Giới tính",
              style: TextStyle(fontWeight: FontWeight.w500),
              children: [
                TextSpan(text: " *", style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: genderOption(label: "male")),
              const SizedBox(width: 12),
              Expanded(child: genderOption(label: "female")),
            ],
          ),
        ],
      ),
    );
  }

  Widget genderOption({String label = 'male'}) {
    bool isSelected = label == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          gender = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? GlobalColors.mainColor : Colors.grey.shade300,
          ),
          color: isSelected ? const Color(0xFFE7F1FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                isSelected
                    ? Image.asset(
                      GlobalImageIcons.radioButtonCheckedIcon,
                      width: 20,
                    )
                    : Image.asset(GlobalImageIcons.radioButtonIcon, width: 20),

                SizedBox(width: 4),

                Text(
                  label == 'male' ? 'Nam' : 'Nữ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child:
                  label == 'male'
                      ? Image.asset(GlobalImageIcons.maleIcon, width: 20)
                      : Image.asset(GlobalImageIcons.femaleIcon, width: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker({required TextEditingController controller}) {
    if (controller.text.isNotEmpty) {
      try {
        selectedDate = DateFormat('dd/MM/yyyy').parse(controller.text);
      } catch (e) {
        selectedDate = DateTime.now();
      }
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text(
                  "Huỷ",
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  "Xác nhận",
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  controller.text = DateFormat(
                    'dd/MM/yyyy',
                  ).format(selectedDate);

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: CupertinoDatePicker(
            initialDateTime: selectedDate,
            mode: CupertinoDatePickerMode.date,
            minimumYear: 1900,
            maximumYear: DateTime.now().year,
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              selectedDate = newDate;
            },
          ),
        ),
      ],
    );
  }
}
