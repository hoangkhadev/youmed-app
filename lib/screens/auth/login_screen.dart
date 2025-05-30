import 'package:flutter/material.dart';
import 'package:my_flutter_app/models/request/login_request.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:my_flutter_app/screens/main_screen.dart';
import 'package:my_flutter_app/utils/global.colors.dart';
import 'package:my_flutter_app/utils/gobal.images.icons.dart';
import 'package:my_flutter_app/widgets/overlay.dart';
import 'package:my_flutter_app/widgets/toast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static final id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      FocusScope.of(context).unfocus();
    });

    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final res = await authProvider.login(
        LoginRequest(phone: phone, password: password),
      );
      if (!mounted) return;

      if (res.success) {
        Toast.show(
          context: context,
          message: 'Đăng nhập thành công!',
          type: ToastType.success,
          duration: 1,
        );

        Future.delayed(Duration(seconds: 2));

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, MainScreen.id, arguments: 0);
      } else {
        Toast.show(
          context: context,
          message: res.message,
          type: ToastType.error,
        );
      }
    } catch (e) {
      if (!mounted) return;

      Toast.show(
        context: context,
        message: 'Đã xảy ra lỗi. Vui lòng thử lại.',
        type: ToastType.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 20,
                        color: GlobalColors.subTextColor,
                      ),
                    ),

                    SizedBox(height: 30),

                    Image.asset(GlobalImageIcons.authLogo, width: 150),
                    SizedBox(height: 20),
                    Text(
                      'Thông tin đăng nhập',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),

                    SizedBox(height: 16),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _phoneController,
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
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isObscure,
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
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                color:
                                    _isObscure
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
                              } else if (value.length < 6) {
                                return 'Mật khẩu phải từ 6 ký tự';
                              }
                              return null;
                            },
                          ),

                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                overlayColor: WidgetStateProperty.all(
                                  GlobalColors.mainColor.withValues(
                                    alpha: 0.05,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Quên mật khẩu?',
                                style: TextStyle(
                                  color: GlobalColors.subTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        side: BorderSide(color: GlobalColors.mainColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: GlobalColors.mainColor,
                      ),
                      child: Text(
                        'Đăng ký tài khoản',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: GlobalColors.mainColor,
                        ),
                      ),
                    ),

                    SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
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
                                'Đăng nhập',
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
            ),

            if (_isLoading) LoadingOverlay(),
          ],
        ),
      ),
    );
  }
}
