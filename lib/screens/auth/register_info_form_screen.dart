import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/profile_form.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class RegisterInfoFormScreen extends StatefulWidget {
  static final id = 'register_info_form_screen';
  const RegisterInfoFormScreen({super.key});

  @override
  State<RegisterInfoFormScreen> createState() => _RegisterInfoFormScreenState();
}

class _RegisterInfoFormScreenState extends State<RegisterInfoFormScreen> {
  final GlobalKey<ProfileFormState> profileFormKey =
      GlobalKey<ProfileFormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushReplacementNamed(context, MainScreen.id, arguments: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GlobalColors.mainColor,
        centerTitle: true,
        title: Text(
          'Khởi tạo hồ sơ y tế',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: ScrollableScreenWrapper(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              Text(
                'Tạo hồ sơ y tế để đặt khám dễ dàng hơn',
                style: TextStyle(
                  color: GlobalColors.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              ProfileForm(formKey: _formKey, key: profileFormKey),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: ElevatedButton(
          onPressed: _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.mainColor,
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            'Tiếp tục',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
