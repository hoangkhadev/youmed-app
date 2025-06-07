import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/auth/register_info_form_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/global.images.icons.dart';
import 'package:my_flutter_app/widgets/custom_dialog.dart';
import 'package:my_flutter_app/widgets/overlay.dart';
import 'package:my_flutter_app/widgets/scrollable_screen_wrapper.dart';
import 'package:my_flutter_app/widgets/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static final id = 'register_phone_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool _isLoading = false;
  bool _isObscurePassword = true;
  bool _isObscurePasswordConfirm = true;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
  }

  void _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await context.read<AuthProvider>().register(phone, password);

      if (mounted) {
        Toast.show(
          context: context,
          message: 'Đăng ký thành công',
          type: ToastType.success,
          duration: 2,
        );

        Navigator.pushReplacementNamed(context, RegisterInfoFormScreen.id);
      }
    } catch (e) {
      final messageError = e.toString();
      if (mounted) {
        if (messageError.contains('đã có tài khoản')) {
          showDialog(
            context: context,
            builder:
                (_) => CustomDialog(
                  onConfirm: () {
                    Navigator.pop(context);
                  },
                  title: 'Tài khoản',
                  description: messageError,
                  cancleText: 'Đóng',
                  confirmText: 'Đăng nhập',
                ),
          );
        } else {
          Toast.show(
            context: context,
            message: e.toString(),
            type: ToastType.error,
          );
        }
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        centerTitle: true,
        title: Text(
          'Đăng ký tài khoản',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: ScrollableScreenWrapper(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(GlobalImageIcons.authLogo, width: 180),
                      SizedBox(height: 20),
                      Text(
                        'Nhập thông tin đăng ký',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: GlobalColors.textColor,
                        ),
                      ),

                      SizedBox(height: 16),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _phoneController,
                              onChanged: (_) => setState(() {}),
                              decoration: InputDecoration(
                                hintText: '0901234567',
                                labelText: 'Số điện thoại',
                                hintStyle: TextStyle(
                                  color: GlobalColors.subTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                floatingLabelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: GlobalColors.mainColor,
                                    width: 1.5,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red.shade800,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Vui lòng nhập số điện thoại';
                                } else if (value.trim().length != 10) {
                                  return 'Số điện thoại không hợp lệ';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),

                            TextFormField(
                              controller: _passwordController,
                              onChanged: (_) => setState(() {}),
                              obscureText: _isObscurePassword,
                              decoration: InputDecoration(
                                hintText: 'Nhập mật khẩu',
                                labelText: 'Mật khẩu',
                                hintStyle: TextStyle(
                                  color: GlobalColors.subTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                floatingLabelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePassword = !_isObscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  color:
                                      _isObscurePassword
                                          ? GlobalColors.subTextColor
                                          : GlobalColors.textColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: GlobalColors.mainColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Vui lòng nhập mật khẩu';
                                } else if (value.trim().length < 6) {
                                  return 'Mật khẩu phải từ 6 ký tự';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordConfirmController,
                              onChanged: (_) => setState(() {}),
                              obscureText: _isObscurePasswordConfirm,
                              decoration: InputDecoration(
                                hintText: 'Nhập lại mật khẩu',
                                labelText: 'Nhập lại mật khẩu',
                                hintStyle: TextStyle(
                                  color: GlobalColors.subTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                labelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                floatingLabelStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isObscurePasswordConfirm =
                                          !_isObscurePasswordConfirm;
                                    });
                                  },
                                  icon: Icon(
                                    _isObscurePasswordConfirm
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  color:
                                      _isObscurePasswordConfirm
                                          ? GlobalColors.subTextColor
                                          : GlobalColors.textColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: GlobalColors.mainColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Vui lòng nhập nhập lại mật khẩu';
                                } else if (value.trim().length < 6) {
                                  return 'Mật khẩu phải từ 6 ký tự';
                                } else if (_passwordController.text != value) {
                                  return 'Nhập lại mật khẩu không khớp';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16),

                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: GlobalColors.textColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        'Bằng việc tiếp tục, bạn đã đồng ý với các ',
                                  ),
                                  TextSpan(
                                    text:
                                        'Điều khoản, điều kiện sử dụng của chúng tôi.',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: GlobalColors.mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12),

                      ElevatedButton(
                        onPressed:
                            _isLoading ||
                                    _phoneController.text.trim().isEmpty ||
                                    _passwordController.text.trim().isEmpty ||
                                    _passwordConfirmController.text
                                        .trim()
                                        .isEmpty
                                ? null
                                : () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RegisterInfoFormScreen.id,
                                  );
                                },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: GlobalColors.mainColor.withValues(
                            alpha: _isLoading ? 0.5 : 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: GlobalColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            _isLoading
                                ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1,
                                  ),
                                )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (_isLoading) LoadingOverlay(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
