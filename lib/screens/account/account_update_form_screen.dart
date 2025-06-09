import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/user_model.dart';
import 'package:my_flutter_app/widgets/overlay.dart';
import 'package:my_flutter_app/widgets/toast.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/services/user_service.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/widgets/profile_form.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';

class AccountUpdateFormScreen extends StatefulWidget {
  static final id = 'account_update_info_form_screen';
  const AccountUpdateFormScreen({super.key});

  @override
  State<AccountUpdateFormScreen> createState() =>
      _AccountUpdateFormScreenState();
}

class _AccountUpdateFormScreenState extends State<AccountUpdateFormScreen> {
  final GlobalKey<ProfileFormState> profileFormKey =
      GlobalKey<ProfileFormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final loading = LoadingOverlay();

  void _handleSubmit() async {
    try {
      if (!_formKey.currentState!.validate()) return;
      FocusScope.of(context).unfocus();

      loading.show(context);

      final formData = profileFormKey.currentState?.getFormData();
      final userService = UserService();

      final authProvider = context.read<AuthProvider>();
      final currentUser = authProvider.currentUser;

      final userToUpdate = UserModel(
        id: currentUser!.id,
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
        await authProvider.refreshCurrentUser();
        loading.hide();
        if (!mounted) return;
        await Toast.show(
          context: context,
          message: 'Cập nhập thành công',
          type: ToastType.success,
          duration: 1,
        );

        if (!mounted) return;
        Navigator.pop(context);
      }
    } catch (e) {
      loading.hide();
      if (!mounted) return;
      await Toast.show(
        context: context,
        message: e.toString(),
        type: ToastType.error,
        duration: 1,
      );
    } finally {
      loading.hide();
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
          'Điều chỉnh hồ sơ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: ScrollableScreenWrapper(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              ProfileForm(
                formKey: _formKey,
                key: profileFormKey,
                initialData: context.watch<AuthProvider>().currentUser,
                isRegister: false,
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
            'Lưu',
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
