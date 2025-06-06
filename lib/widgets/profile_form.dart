import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_flutter_app/models/user_model.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/custom_bottom_sheet.dart';

class ProfileForm extends StatefulWidget {
  final UserModel? initialData;
  final GlobalKey<FormState> formKey;

  const ProfileForm({super.key, this.initialData, required this.formKey});

  @override
  State<ProfileForm> createState() => ProfileFormState();
}

class ProfileFormState extends State<ProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _emailController;
  late TextEditingController _cityController;
  late TextEditingController _districtController;
  late TextEditingController _wardController;
  late TextEditingController _address2Controller;

  String gender = 'male';

  Map<String, dynamic> getFormData() {
    return {
      'fullName': _nameController.text,
      'phone': _phoneController.text,
      'dob': _dobController.text,
      'email': _emailController.text,
      'city': _cityController.text,
      'district': _districtController.text,
      'ward': _wardController.text,
      'address2': _address2Controller.text,
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

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;

    _nameController = TextEditingController(text: data?.fullName ?? '');
    _phoneController = TextEditingController(text: data?.phone ?? '');
    _dobController = TextEditingController(text: data?.dobFormated ?? '');
    _emailController = TextEditingController(text: data?.email ?? '');
    _cityController = TextEditingController(text: data?.city ?? '');
    _districtController = TextEditingController(text: data?.district ?? '');
    _wardController = TextEditingController(text: data?.ward ?? '');
    _address2Controller = TextEditingController(text: data?.address2 ?? '');

    gender = data?.gender ?? 'male';
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
              onPressed: () {},
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
                return 'Vui chọn ngày sinh';
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

  Widget genderOption({required String label}) {
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
    DateTime selectedDate = DateTime.now();

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
                onPressed: () => Navigator.pop(context),
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
