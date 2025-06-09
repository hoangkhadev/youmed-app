import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/services/user_service.dart';
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
    final formData = profileFormKey.currentState?.getFormData();
    final userService = UserService();

    final authProvider = context.read<AuthProvider>();
    final currentUser = authProvider.currentUser;

    final userToUpdate = UserModel(
      id: currentUser?.id ?? "1232",
      fullName: formData!['full_name'],
      phone: formData['phone'],
      dob: formData['dob'],
      email: formData['email'],
      gender: formData['gender'],
      city: formData['city'],
      district: formData['district'],
      ward: formData['ward'],
      address2: formData['address2'],
    );

    final updatedUser = await userService.update(userToUpdate);
    if (updatedUser != null) {
      if (mounted) {
        await authProvider.refreshCurrentUser();
      }

      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          MainScreen.id,
          arguments: {'currentIndex': 0},
        );
      }
    }
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
              ProfileForm(
                formKey: _formKey,
                key: profileFormKey,
                initialData: context.watch<AuthProvider>().currentUser,
              ),
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
